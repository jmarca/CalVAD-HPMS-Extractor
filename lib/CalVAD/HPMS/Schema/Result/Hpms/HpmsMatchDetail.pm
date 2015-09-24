use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms.hpms_match_details>

=cut

__PACKAGE__->table("hpms.hpms_match_details");

=head1 ACCESSORS

=head2 hpms_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 direction

  data_type: 'text'
  is_nullable: 0

=head2 intended_name

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 intended_from

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 intended_to

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 matched_name

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 matched_from

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 matched_to

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=cut

__PACKAGE__->add_columns(
  "hpms_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "direction",
  { data_type => "text", is_nullable => 0 },
  "intended_name",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "intended_from",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "intended_to",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "matched_name",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "matched_from",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "matched_to",
  { data_type => "varchar", is_nullable => 1, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</hpms_id>

=item * L</direction>

=back

=cut

__PACKAGE__->set_primary_key("hpms_id", "direction");

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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-24 10:10:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zFH1yaQ1RBIlQsK2KTMCJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
