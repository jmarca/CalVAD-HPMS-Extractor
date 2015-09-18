use utf8;
package CalVAD::HPMS::Schema::Result::HPMS::HPMSLinkGeom;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::HPMS::HPMSLinkGeom

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms_link_geom>

=cut

__PACKAGE__->table("hpms_link_geom");

=head1 ACCESSORS

=head2 geo_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 hpms_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 direction

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "geo_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "hpms_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "direction",
  { data_type => "text", is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<hpms_link_geom_hpms_id_direction_key>

=over 4

=item * L</hpms_id>

=item * L</direction>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "hpms_link_geom_hpms_id_direction_key",
  ["hpms_id", "direction"],
);

=head1 RELATIONS

=head2 geo

Type: belongs_to

Related object: L<CalVAD::HPMS::Schema::Result::HPMS::HPMSGeom>

=cut

__PACKAGE__->belongs_to(
  "geo",
  "CalVAD::HPMS::Schema::Result::HPMS::HPMSGeom",
  { id => "geo_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);

=head2 hpm

Type: belongs_to

Related object: L<CalVAD::HPMS::Schema::Result::HPMS::HPMS>

=cut

__PACKAGE__->belongs_to(
  "hpm",
  "CalVAD::HPMS::Schema::Result::HPMS::HPMS",
  { id => "hpms_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-17 18:41:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/dYCWeuszHnZzr3izurwSw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
