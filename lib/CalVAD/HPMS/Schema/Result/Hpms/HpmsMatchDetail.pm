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

=head2 matched_name_from

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=head2 matched_name_to

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
  "matched_name_from",
  { data_type => "varchar", is_nullable => 1, size => 256 },
  "matched_name_to",
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


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-10-01 16:26:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oajZuTpv5EBYkWIBf7NUwA
# These lines were loaded from '/usr/local/share/perl5/CalVAD/HPMS/Schema/Result/Hpms/HpmsMatchDetail.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE


use strict;
use warnings;

use base 'DBIx::Class::Core';


__PACKAGE__->table("hpms.hpms_match_details");


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


__PACKAGE__->set_primary_key("hpms_id", "direction");


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

__END__

=pod

=encoding UTF-8

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail

=head1 VERSION

version 0.002

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail

=head1 TABLE: C<hpms.hpms_match_details>

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

=head1 PRIMARY KEY

=over 4

=item * L</hpms_id>

=item * L</direction>

=back

=head1 RELATIONS

=head2 hpm

Type: belongs_to

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HPMS>

=head1 AUTHOR

James E. Marca <james@activimetrics.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by James E. Marca.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
# End of lines loaded from '/usr/local/share/perl5/CalVAD/HPMS/Schema/Result/Hpms/HpmsMatchDetail.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
