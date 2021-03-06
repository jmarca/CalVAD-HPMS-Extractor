use Test::Modern; # see done_testing()
use Carp;
use Data::Dumper;
use Config::Any; # config db credentials with config.json


use DBI;

use CalVAD::HPMS::Schema ;
use CalVAD::HPMS::Extractor;

ok(1,'use okay passed');



##################################################
# read the config file
##################################################
my $config_file = './test.config.json';
my $cfg = {};

# check if right permissions on file, if so, use it
if( -e $config_file){
    my @mode = (stat($config_file));
    my $str_mode = sprintf "%04o", $mode[2];
    if( $str_mode == 100600 ){

        $cfg = Config::Any->load_files({files => [$config_file],
                                        flatten_to_hash=>1,
                                        use_ext => 1,
                                       });
        # simplify the hashref down to just the one file
        $cfg = $cfg->{$config_file};
    }else{
        croak "permissions for $config_file are $str_mode.  Set permissions to 0600 (only the user can read or write)";
    }
}
else{
  # if no config file, then just note that and move on
    carp "no config file $config_file found";
}


##################################################
# translate config file into variables, for command line override
##################################################

my $path     = $cfg->{'path'};
my $help;

my $user = $cfg->{'postgresql'}->{'auth'}->{'username'} || q{};
# never use a postgres password, use config file or .pgpass
my $host = $cfg->{'postgresql'}->{'host'} || '127.0.0.1';
my $dbname =
    $cfg->{'postgresql'}->{'hpmsdb'};

my $port = $cfg->{'postgresql'}->{'port'} || 5432;


my $admindb = $cfg->{'postgresql'}->{'admin'}->{'db'} || 'postgres';
my $adminuser = $cfg->{'postgresql'}->{'admin'}->{'user'} || 'postgres';


isnt($port,undef,'need a valid pg port defined in config file');
isnt($user,undef,'need a valid pg user defined in config file');
isnt($dbname,undef,'need a valid pg db defined in config file');
isnt($host,undef,'need a valid pg host defined in config file');

##################################################
# create testing database
##################################################

my $admin_dbh;
eval{
    $admin_dbh = DBI->connect("dbi:Pg:dbname=$admindb;host=$host;port=$port", $adminuser);
};
if($@) {
    carp 'must have valid admin credentials in test.config.json, and a valid admin password setup in .pgpass file';
    croak $@;
}

my $create = "create database $dbname";
if($user ne $adminuser){
    $create .= " with owner $user";
}
eval {
        $admin_dbh->do($create);
};
if($@) {
    carp 'test db creation failed';
    carp $@;
    carp Dumper [
        'host_psql'=>$host,
        'port_psql'=>$port,
        'dbname_psql'=>$dbname,
        'admin database'=>$admindb,
        'admin user'=>$adminuser,
        ];

    croak 'failed to create test database';
}

## deploy required tables via DBIx::Class

## deploy just the tables I'm going to be accessing during testing

## create postgis extensions
my $postgis_args =  ["psql",
                      "-d", "$dbname",
                      "-U", "$user",
                      "-h", "$host",
                      "-p", "$port",
                     "-c", "CREATE EXTENSION postgis;"];

# topology not strictly necessary
my $postgis_topology_args =  ["psql",
                              "-d", "$dbname",
                              "-U", "$user",
                              "-h", "$host",
                              "-p", "$port",
                              "-c", "CREATE EXTENSION postgis_topology;"];
my $db_deploy_args = ["psql",
                      "-d", "$dbname",
                      "-U", "$user",
                      "-h", "$host",
                      "-p", "$port",
                      "-f", "./sql/create_hpms_table.sql"];

my $db_populate_args = ["psql",
                    "-d", "$dbname",
                    "-U", "$user",
                    "-h", "$host",
                    "-p", "$port",
                    "-f", "./sql/hpms_test_db.sql"];
for my $args ( $postgis_args, $postgis_topology_args, $db_deploy_args,
    $db_populate_args )
{
    my @sysargs = @{$args};
    system(@sysargs) == 0
      or croak "system @sysargs failed: $?";
}

# make a parser of data
my $extractor  = CalVAD::HPMS::Extractor->new(

    # first the sql role
    'host_psql'     => $host,
    'port_psql'     => $port,
    'dbname_psql'   => $dbname,
    'username_psql' => $user,

);

isnt($extractor, undef, 'object creation should work with all required fields');
isa_ok($extractor,'CalVAD::HPMS::Extractor','extractor is an extractor');

my $connect;
eval {
  $connect = $extractor->_connection_psql;
};
if($@) {
  carp $@;
}

isnt($connect, undef, 'db connection should be possible');
isa_ok($connect,'CalVAD::HPMS::Schema','db connection is right class');

# test simple query works

my $rs = $extractor->resultset('Hpms::HPMS');
isa_ok($rs,'DBIx::Class::ResultSet','got a result set');
my @all = $rs->all();
is(@all,4488,'got everything from test database');



# use the extractor

my $max = 20;

$extractor->extract_out(sub{
    ($rs) = @_;

    my $cursor = $rs->cursor;

    while ($max && (my @vals = $cursor->next)) {
        $max--;
        # my $val_or_blank = [map { $_ || ''} @vals];
        # diag (join q/,/,@{$val_or_blank} );
    }
                        });
is( $max, 10 );

my $newpage = $rs->page(2);
my $cursor = $newpage->cursor;
$max = 20;
my @vals;
while ($max && ( @vals = $cursor->next)) {
    $max--;
    # my $val_or_blank = [map { $_ || ''} @vals];
    # diag (join q/,/,@{$val_or_blank} );
}
is( $max, 10 );


# see if we can't get 100
$extractor->rows(100);
$extractor->extract_out(sub{
    ($rs) = @_;

    $cursor = $rs->cursor;
    $max = 110;
    while ($max && (my @vals = $cursor->next)) {
        $max--;
        # my $val_or_blank = [map { $_ || ''} @vals];
        # diag (join q/,/,@{$val_or_blank} );
    }
    is( $max, 10 );
  });


# try to create a geometry

$newpage = $rs->page(3);
$cursor = $newpage->cursor;
@vals = $cursor->next;
my $hpmsid = $vals[0];

my $geometry_wkb = '0102000020E61000000D000000AAF5D95C90C05DC092544BDF10004240F63D8FF664C05DC0AB9C514E0F00424086600B3062C05DC00FB8AE98110042400415FA0560C05DC0F683150214004240EB4DB10F57C05DC0E54C6E6F120042400C94145800C05DC026E0D748120042407E569929ADBF5DC0E0675C381000424014ECBFCE4DBF5DC0469561DC0D004240CA1B60E63BBF5DC037FA980F08004240FF3F4E9830BF5DC0EFC8586DFEFF41407F9B6AD212BF5DC0CF21BAB1EAFF41409262DBFD05BF5DC04AF7297DD7FF4140BA2B60A7FDBE5DC0363A8CEEC5FF4140';

my $geom_result = $extractor->create_geometry($hpmsid,'',$geometry_wkb);
is($geom_result, 1);

# double check
# should no longer be visible to the $rs result set query
my $hpms_record = $rs->find($hpmsid);
is($hpms_record,undef);

my $cleanrs = $extractor->rs_query();
$hpms_record = $cleanrs->find($hpmsid);
isnt($hpms_record,undef);
is($hpms_record->id,$hpmsid);

my @linked = $hpms_record->search_related('hpms_link_geoms');
is($linked[0]->geo_id,1);
@linked = $hpms_record->search_related('hpms_failed_geom');
is($linked[0],undef);


@vals = $cursor->next;
$hpmsid = $vals[0];

$geom_result = $extractor->create_geometry($hpmsid,'');
is($geom_result, -1);

# double check
$hpms_record = $rs->find($hpmsid);
is($hpms_record,undef);

$hpms_record = $cleanrs->find($hpmsid);
isnt($hpms_record,undef);
is($hpms_record->id,$hpmsid);

is($hpms_record->id,$hpmsid);
@linked = $hpms_record->search_related('hpms_link_geoms');
is($linked[0],undef);
@linked = $hpms_record->search_related('hpms_failed_geom');
is($linked[0]->hpms_id,$hpmsid);


# now test out guessing names
$extractor->extract_out(sub{
    my ($rs) = @_;

    my $cursor = $rs->cursor;

    while (my @vals = $cursor->next) {
        my $result = $extractor->guess_name_to_from(\@vals);
        isa_ok($result,'HASH');
        # my $val_or_blank = [map { $_ || ''} @vals];
        # diag (join q/,/,@{$val_or_blank} );
    }
                        }
    );

# and some specific test cases

my @case = (0,1,2,3,'000000004U01','CHARTER WAY/MLK JR BLVD',
            6,7,8,9,10,11,12,13,14,
            'SJ:STKN:CHARTER WAY/MLK JR BLVD:AIRPORT WAY:MARIPOSA RD');
my $res = $extractor->guess_name_to_from(\@case);

isnt($res,undef);
isa_ok($res,'HASH');
is($res->{'name'},'CHARTER WAY/MLK JR BLVD');
is($res->{'from'},'AIRPORT WAY');
is($res->{'to'},'MARIPOSA RD');


##################################################
@case = (0,1,2,3,'TUL_CO_DIAGONAL 126/MAIN at AVENUE 96','DIAGONAL 126/MAIN',
            6,7,8,9,10,11,12,13,14,
            'AVENUE 96 to ROAD 124/PARK ST');
$res = $extractor->guess_name_to_from(\@case);

isnt($res,undef);
isa_ok($res,'HASH');
is($res->{'name'},'DIAGONAL 126/MAIN');
is($res->{'from'},'AVENUE 96');
is($res->{'to'},'ROAD 124/PARK ST');

##################################################
@case = (0,1,2,3,'TUL_FMVL_FRANQUETTE AVE',undef,
            6,7,8,9,10,11,12,13,14,
            'WALNUT AVE to MARILYN ST');
$res = $extractor->guess_name_to_from(\@case);

isnt($res,undef);
isa_ok($res,'HASH');
is($res->{'name'},'TUL_FMVL_FRANQUETTE AVE');
is($res->{'from'},'WALNUT AVE');
is($res->{'to'},'MARILYN ST');


##################################################
@case = (0,1,2,3,'TUL_USFS_SHERMAN PASS RD','SHERMAN PASS RD',
            6,7,8,9,10,11,12,13,14,
            'RD TO BIG MEADOW CP to PINON VILLAGE RD');


$res = $extractor->guess_name_to_from(\@case);

isnt($res,undef);
isa_ok($res,'HASH');
is($res->{'name'},'SHERMAN PASS RD');
is($res->{'from'},'RD TO BIG MEADOW CP');
is($res->{'to'},'PINON VILLAGE RD');




##################################################
# now test saving the geocode results

@vals = $cursor->next;
$hpmsid = $vals[0];

$res = $extractor->save_geocode_results(
    'hpmsid'=>$hpmsid,
    'direction'=>'',
    'intended_name'=>'SHERMAN PASS RD',
    'intended_from'=>'RD TO BIG MEADOW CP',
    'intended_to'  =>'PINON VILLAGE RD',
    'matched_name_to' => undef,
    'matched_name_from' => undef,
    'matched_from' =>undef,
    'matched_to'   =>undef
    );

@vals = $cursor->next;
$hpmsid = $vals[0];

$res = $extractor->save_geocode_results(
    'hpmsid'=>$hpmsid,
    'direction'=>'',
    'intended_name'=>'AVENUE 116',
    'intended_from'=>'DIAGONAL 254',
    'intended_to'  =>'ROAD 264',
    'matched_name_from' =>'Avenue 116',
    'matched_name_to' =>'Avenue 116',
    'matched_from' =>'Road 264',
    'matched_to'   =>'Diagonal 27',
    );

my @records = $extractor->resultset('Hpms::HpmsMatchDetail')->all();

is(@records,2,'got two match detail records');

done_testing;



END{
    # $connect = undef;
    # $obj = undef;
    eval{
        my $dbh = DBI->connect("dbi:Pg:dbname=$admindb;host=$host;port=$port", $adminuser);
        $dbh->do("drop database $dbname");
    };
    if($@){
        carp $@;
    }
}
