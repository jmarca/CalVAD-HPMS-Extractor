# ABSTRACT: access and process HPMS records, primarily for geocoding
use Modern::Perl '2014';
use Moops;

package CalVAD::HPMS;


class Extractor using Moose : ro {
    use Carp;
    use Data::Dumper;
    use English qw(-no_match_vars);
    use version; our $VERSION = qv('0.1.0');
    use Try::Tiny;

    use CalVAD::HPMS::Schema;

    has 'hpms_columns' => (
        'is'    => 'ro',
        'isa'   => 'ArrayRef',
        default => sub {
            [
             qw(id year_record route_number  route_qualifier route_id alternative_route_name_txt urban_code_cmt  county_code    county_code_cmt  begin_point end_point section_length f_system_cmt nhs_cmt aadt aadt_cmt)
            ];
        },
        );


    has 'shwy' => (is => 'rw', isa => 'Bool', 'default'=>0);
    has 'retry' => (is => 'rw', isa => 'Bool', 'default'=>0);
    has 'rows' => (is => 'rw', isa => 'Num', 'default'=>10);


    my $param = 'psql';

    method _build__connection_psql {

        # process my passed options for psql attributes
        my ( $host, $port, $dbname, $username ) =
          map { $self->$_ }
          map { join q{_}, $_, $param }
          qw/ host port dbname username /;
        my $pass;
        my $vdb = CalVAD::HPMS::Schema->connect(
            "dbi:Pg:dbname=$dbname;host=$host;port=$port",
            $username, $pass, { on_connect_do =>
                        [ 'SET search_path TO public' ], ## no hpms schema now
                    },
        );
        return $vdb;
    }
    with 'DB::Connection' => {
        'name'                  => 'psql',
        'connection_type'       => 'CalVAD::HPMS::Schema',
        'connection_delegation' => qr/^(.*)/sxm,
    };

    method rs_query {

        my $rs = $self->resultset('Hpms::HPMS')->search(
                                                      {},
            {
                'select' => $self->hpms_columns,

                'join' => [qw/ hpms_link_geoms hpms_failed_geom  /],
                                ## max_len
            }
        );

        return $rs;
    }

    method create_geometry (Num $hpmsid, Str $direction, Any $geom? ){
        my $result = 0;
        my $test_eval;
        my $new_geom;
        my $new_join;
        if ($geom) {
            # carp "saving geometry $hpmsid, $direction";
            my $rs = $self->resultset('Hpms::HpmsGeom');
            # carp Dumper $rs;
            $test_eval = eval {
                $new_geom = $rs->create(
                    { 'geom' => $geom }

                );
            };
            if ($EVAL_ERROR) {    # find or create failed
                carp "can't create new geometry $EVAL_ERROR";
                croak;
            }

            # join the geom and the hpms record
            $test_eval = eval {
                $new_join = $self->resultset('Hpms::HpmsLinkGeom')->create(
                    {
                        'geo_id'    => $new_geom->id(),
                        'hpms_id'   => $hpmsid,
                        'direction' => $direction,
                    }

                );
            };
            if ($EVAL_ERROR) {    # find or create failed
                carp "can't create new join table entry $EVAL_ERROR";
                croak;
            }
            $result = 1;
        }else{
            # carp "no geometry, creating an entry in the failed table for $hpmsid, $direction";
            # no geometry to join, save to the failed table
            # join the geom and the hpms record
            $test_eval = eval {
                $new_join = $self->resultset('Hpms::HpmsFailedGeom')->create(
                    { 'hpms_id' => $hpmsid, }

                );
            };
            if ($EVAL_ERROR) {    # find or create failed
                carp
                  "can't create new failed geom join table entry $EVAL_ERROR";
                croak;
            }
            $result = -1;
        }
        return $result;
    }

    method save_geocode_results (Num :$hpmsid,
                                 Str :$direction,
                                 Str :$intended_name,
                                 Maybe[Str] :$intended_from?,
                                 Maybe[Str] :$intended_to?,
                                 Str :$matched_name,
                                 Maybe[Str] :$matched_from?,
                                 Maybe[Str] :$matched_to?, ){
        my $result = 0;
        my $test_eval;
        my $new_join;
        $test_eval = eval {
            $new_join = $self->resultset('Hpms::HpmsMatchDetail')->create(
                    {
                        'hpms_id'   => $hpmsid,
                        'direction' => $direction,
                        'intended_name' => $intended_name,
                        'intended_from' => $intended_from,
                        'intended_to' => $intended_to,
                        'matched_name' => $matched_name,
                        'matched_from' => $matched_from,
                        'matched_to' => $matched_to,
                    }
                );
        };
        if ($EVAL_ERROR) {    # find or create failed
            carp "can't join geocode results $EVAL_ERROR";
            croak;
        }
        return $new_join;
    }

    method extract_out  (CodeRef $callback)  {
        my $data_rs    = $self->rs_query();
        my $conditions = {
            'hpms_link_geoms'   => undef,
            'hpms_failed_geom' => undef,
            'aadt' => { '!=',undef},
            'aadt' => { '>',0 },
            'alternative_route_name_txt' => { '!~*', 'GROUP' },
        };
        my $options = {
            rows     => $self->rows,      # number of results per page
            order_by => 'random()',
        };
        if($self->retry && $conditions->{'hpms_failed_geom'} ){
            delete $conditions->{'hpms_failed_geom'};
        }
        if ( ! $self->shwy ) {
            $conditions->{'alternative_route_name_txt'} = {'!=',undef};
        }
        # not being used at the moment
        if ( $self->shwy ) {
            $conditions->{'alternative_route_name_txt'} = {'~*','shwy'};
        }
        if ( $self->shwy && $self->osmref ) {
            $conditions->{'me.route_number'} = {'!=',''};
        }
        # carp Dumper $conditions;
        # carp Dumper $options;

        my $rs = $data_rs->search( $conditions, $options, );
        if ($rs) {
            $callback->($rs);
        }
        return;

    }

    method guess_name_to_from(ArrayRef $record ){
        my $from;
        my $to;
        my $name;
        my $county;
        my $city;

        # for now, just best guess
        #
        # later get more tricky, or deploy that web UI I've been
        # thinking about

        # columns at the moment are:
        #
        # id year_record route_number route_qualifier route_id
        # alternative_route_name_txt urban_code_cmt county_code
        # county_code_cmt begin_point end_point section_length
        # f_system_cmt nhs_cmt aadt aadt_cmt

        $name = $record->[5] || $record->[4];

        # source the from to stuff from the aadt cmt

        my $aadtcmt = $record->[15];

        # first attempt, split on 'to'
        my @details = split /\s+to\s+/,$aadtcmt;
        if(scalar @details == 2 ){
            # first batch is from, second is to
            $from = $details[0];
            $to = $details[1];
        }
        # so far in HPMS aadtcmt column, it is never the case that you
        # have two consecutive lowercase ' to ' fields.  So if you
        # have a ' to ', then great.  If not, it could be the case
        # that the split pattern is ' TO ' (uppercase).  There *are*
        # cases with mixed case repeats of TO and to, for example, 'RD
        # TO BIG MEADOW CP to PINON VILLAGE RD', but there are no
        # cases with a double capital case ' TO '.  So, if the above '
        # to ' fails, then check for ' TO '.  But the above case
        # cannot be /\s+to\s+/i (case-insensitive) because it will
        # fail and split RD TO BIG MEADOW.
        if(!$from){
            @details = split /\s+TO\s+/,$aadtcmt;
            if(scalar @details == 2 ){
                # first batch is from, second is to
                $from = $details[0];
                $to = $details[1];
            }
        }

        # next case?  Sometimes there is a 'from' rather than a 'to'
        # in the comment.  Also there can be a 'from' and 'to' For
        # example, the incredibly hard to understand entry: '280/SEG
        # NB FROM 280/1 TO JUNIP SERR BL', illustrated here:
        # https://www.google.com/maps/@37.6863087,-122.4737188,1807m/data=!3m1!1e3
        #
        # but that is actually the only case of 'from' and 'to' in the
        # aadt_cmt field.

        # actually, I am going to skip 'from' right now, because after
        # paging quickly through the 1952 or so cases, they are all
        # onramps or connectors to freeways from some street.  I'm
        # going to ignore ramps and connectors at the moment.

        # seems like if there is no 'to' field, then colons are used

        if(!$from){
            @details = split q{:},$aadtcmt;
            if(scalar @details == 5 ){
                # pattern is
                # CO:CTY:NAME:FROM:TO
                #
                $county = $details[0];
                $city = $details[1];

                # $name2 = $details[2];
                if($name ==  $record->[4] && $name =~ /0000/){
                    # sometimes this doesn't match name at all.
                    # sometimes it is just a little off but record id
                    # is rarely helpful.  use 0000 as a proxy for that
                    # lots of numbers record id.
                    $name = $details[2];
                }
                $from = $details[3];
                $to = $details[4];
            }
        }

        return {
            'from'=>$from,
            'to'=>$to,
            'name'=>$name,
        };


    }

}

1;

=method _build__connection_psql

    This method is required by DB::Connection

=method rs_query

    This method creates an initial DBIx::Class result set, fetch
    hpms_columns and linking hpms_link_geoms and hpms_failed_geom.

=method create_geometry

    This method is passed an hpmsid, a direction (which can be blank
    string) and a geom as wkb.  If the geom variable is not null, then
    the a new geometry is created and linked to the given hpms id.  If
    the geometry is null, then an entry is created in the
    hpms_failed_geom table.

=method extract_out

    This method creates a DBIx::Class result set, and passes it to the
    given callback.  The callback can then further modify the result
    set if desired, or else just get the results from the db, and do
    something with them.

    In the context of geocoding, the callback would individually
    geocode each row fetched from the database.

=method save_geocode_results

    This method will save the geocode results.  The geocode process
    (in CalVAD::HPMS::Geocode at the moment) does its best to match
    the road name, the from name, and the to name.  It is sometimes
    the case that the matching is really bad.  This table exists so
    that I can review any problems after the fact.  Pass in the
    intended road name, from name, and to name, as well as the matched
    road name, matched from name, and matched to name.

=method guess_name_to_from

    This method will look at a record queried from the database (using
    the standard columns) and will try to guess the name of the
    segment, the road identifying the start of the segment ('from')
    and the road identifying the end of the segment ('to').
    Unfortunately, the HPMS data is wildly inconsistent here, so we
    just do the best we can.

=attr hpms_columns

    A read-only list of columns that will be fetched by default upon
    calls to extract_out or rs_query.  Intialized on object creation.
    The default list of variables is

        qw(id year_record route_number route_qualifier route_id
           alternative_route_name_txt urban_code_cmt county_code
           county_code_cmt begin_point end_point section_length
           f_system_cmt nhs_cmt aadt aadt_cmt)

=attr shwy

    shwy is a binary flag variable.  It is intended to modify the
    conditions placed upon the query generated by the extract_out
    method.

    It isn't really used any more, because at the moment (2015)
    Caltrans has released a shapefile containing AADT values for each
    of their census stations on all state highways.


=attr retry

    retry is a binary flag variable, defaulting to false (0).  If
    false (the default), the the query generated by extract_out will
    skip any HPMS records that already have an entry in the
    hpms_failed_geom table.  If set to true, then this condition is
    removed, which means that previously failed-to-match HPMS records
    will be run again.

=attr rows

   The number of rows to get per page of results.  Defaults to 10.
