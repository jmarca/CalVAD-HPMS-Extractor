use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms.hpms_failed_geom>

=cut

__PACKAGE__->table("hpms.hpms_failed_geom");

=head1 ACCESSORS

=head2 hpms_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "hpms_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</hpms_id>

=back

=cut

__PACKAGE__->set_primary_key("hpms_id");

=head1 RELATIONS

=head2 hpm

Type: belongs_to

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HPMS>

=cut

__PACKAGE__->belongs_to(
  "hpm",
  "CalVAD::HPMS::Schema::Result::Hpms::HPMS",
  { id => "hpms_id" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-18 13:14:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ttVzRQk88nXuxHoZeNPbFQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
