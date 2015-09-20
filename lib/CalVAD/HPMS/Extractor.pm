# ABSTRACT: turns baubles into trinkets
use strict;
use warnings;
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
            #'hpms_link_geoms'   => undef,
            # 'hpms_failed_geom' => undef,
            #'locality'         => { '!=', 'CO' },

            'alternative_route_name_txt' => { '!~*', 'GROUP' },

            # 'from_name' => {'!=', undef},
            # 'to_name' => {'!=', undef},

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
            #$options->{'+select'}='max_len.len';
            #$options->{'+as'}='max_length';
            #$options->{'join'} = 'max_len';
        }
        if ( $self->shwy && $self->osmref ) {
            $conditions->{'me.route_number'} = {'!=',''};
            # delete $conditions->{'locality'};
            # $options->{'+select'}='max_len.len';
            # $options->{'+as'}='max_length';
            # $options->{'join'} = 'max_len';
        }
        # carp Dumper $conditions;
        # carp Dumper $options;

        my $rs = $data_rs->search( $conditions, $options, );
        if ($rs) {
            $callback->($rs);
        }
        return;

    }


}

1;
