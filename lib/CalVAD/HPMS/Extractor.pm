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

    use CalVAD::HPMS::Schema;

    has 'hpms_columns' => (
        'is'    => 'ro',
        'isa'   => 'ArrayRef',
        default => sub {
            [
             qw(id year_record  locality  county  fips  link_desc  from_name  to_name  lrs_id is_metric begin_lrs end_lrs inter_route_number route_qualifier route_number section_length )
            ];
        },
        );

    has 'county' => (is => 'rw', isa => 'Bool', 'default'=>0);
    has 'shwy' => (is => 'rw', isa => 'Bool', 'default'=>0);
    has 'osmref' => (is => 'rw', isa => 'Bool', 'default'=>0);
    has 'retry' => (is => 'rw', isa => 'Bool', 'default'=>0);


        my $param = 'psql';
    method _build__connection_psql {

        # process my passed options for psql attributes
        my ( $host, $port, $dbname, $username, $password ) =
          map { $self->$_ }
          map { join q{_}, $_, $param }
          qw/ host port dbname username password /;
        my $vdb = HPMS::Schema->connect(
            "dbi:Pg:dbname=$dbname;host=$host;port=$port",
            $username, $password, { on_connect_do =>
                        [ 'SET search_path TO hpms, public' ],
                    },
        );
        return $vdb;
    }
    with 'DB::Connection' => {
        'name'                  => 'psql',
        'connection_type'       => 'CalVAD::HPMS::Schema',
        'connection_delegation' => qr/^(.*)/sxm,
    };


}

1;
