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
            rows     => 10,           # number of results per page
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

    method guess_name_to_from( ArrayRef :$record ){
        # for now, just best guess

        # later get more tricky, or deploy that web UI I've been
        # thinking about

        # columns at the moment are:
        #
        # id year_record route_number route_qualifier route_id
        # alternative_route_name_txt urban_code_cmt county_code
        # county_code_cmt begin_point end_point section_length
        # f_system_cmt nhs_cmt aadt aadt_cmt

        my $name = $record->[5] || $record->[4];

        # source the from to stuff from the aadt cmt

        my $aadtcmt = $record->[15];

        # first attempt, split on 'to'
        my @details = split q{/},$aadtcmt;
        if(scalar @details )
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

=method guess_name_to_from

    This method will look at a record queried from the database (using
    the standard columns) and will try to guess the name of the
    segment, the road identifying the start of the segment ('from')
    and the road identifying the end of the segment ('to').
    Unfortunately, the HPMS data is wildly inconsistent here, so we
    just do the best we can.
