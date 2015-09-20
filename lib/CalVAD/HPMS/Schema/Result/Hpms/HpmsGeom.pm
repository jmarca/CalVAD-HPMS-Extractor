use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HpmsGeom;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HpmsGeom

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms.hpms_geom>

=cut

__PACKAGE__->table("hpms.hpms_geom");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'hpms.hpms_geom_id_seq'

=head2 geom

  data_type: 'geometry'
  is_nullable: 1
  size: '58884,16'

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "hpms.hpms_geom_id_seq",
  },
  "geom",
  { data_type => "geometry", is_nullable => 1, size => "58884,16" },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 hpms_link_geoms

Type: has_many

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom>

=cut

__PACKAGE__->has_many(
  "hpms_link_geoms",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom",
  { "foreign.geo_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-18 13:14:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ALBvTj1j8NxRz+V/+6zFFQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
