use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HPMS;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HPMS

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms.hpms>

=cut

__PACKAGE__->table("hpms.hpms");

=head1 ACCESSORS

=head2 year_record

  data_type: 'double precision'
  is_nullable: 1

=head2 state_code

  data_type: 'double precision'
  is_nullable: 1

=head2 route_id

  data_type: 'text'
  is_nullable: 1

=head2 begin_point

  data_type: 'double precision'
  is_nullable: 1

=head2 end_point

  data_type: 'double precision'
  is_nullable: 1

=head2 section_length

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt_combination

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt_single_unit

  data_type: 'double precision'
  is_nullable: 1

=head2 access_control

  data_type: 'double precision'
  is_nullable: 1

=head2 counter_peak_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 county_code

  data_type: 'double precision'
  is_nullable: 1

=head2 dir_factor

  data_type: 'double precision'
  is_nullable: 1

=head2 facility_type

  data_type: 'double precision'
  is_nullable: 1

=head2 f_system

  data_type: 'double precision'
  is_nullable: 1

=head2 hov_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 hov_type

  data_type: 'double precision'
  is_nullable: 1

=head2 iri

  data_type: 'double precision'
  is_nullable: 1

=head2 k_factor

  data_type: 'double precision'
  is_nullable: 1

=head2 lane_width

  data_type: 'double precision'
  is_nullable: 1

=head2 nhs

  data_type: 'double precision'
  is_nullable: 1

=head2 ownership

  data_type: 'double precision'
  is_nullable: 1

=head2 pct_peak_combination

  data_type: 'double precision'
  is_nullable: 1

=head2 pct_peak_single

  data_type: 'double precision'
  is_nullable: 1

=head2 peak_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 route_number

  data_type: 'double precision'
  is_nullable: 1

=head2 route_qualifier

  data_type: 'double precision'
  is_nullable: 1

=head2 route_signing

  data_type: 'double precision'
  is_nullable: 1

=head2 speed_limit

  data_type: 'double precision'
  is_nullable: 1

=head2 through_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 truck

  data_type: 'double precision'
  is_nullable: 1

=head2 urban_code

  data_type: 'double precision'
  is_nullable: 1

=head2 alternative_route_name_txt

  data_type: 'text'
  is_nullable: 1

=head2 facility_type_cmt

  data_type: 'text'
  is_nullable: 1

=head2 f_system_cmt

  data_type: 'text'
  is_nullable: 1

=head2 iri_cmt

  data_type: 'text'
  is_nullable: 1

=head2 nhs_cmt

  data_type: 'text'
  is_nullable: 1

=head2 ownership_cmt

  data_type: 'text'
  is_nullable: 1

=head2 urban_code_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_combination_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_single_unit_cmt

  data_type: 'text'
  is_nullable: 1

=head2 county_code_cmt

  data_type: 'text'
  is_nullable: 1

=head2 k_factor_cmt

  data_type: 'text'
  is_nullable: 1

=head2 pct_peak_combination_cmt

  data_type: 'text'
  is_nullable: 1

=head2 pct_peak_single_cmt

  data_type: 'text'
  is_nullable: 1

=head2 peak_lanes_cmt

  data_type: 'text'
  is_nullable: 1

=head2 through_lanes_cmt

  data_type: 'text'
  is_nullable: 1

=head2 access_control_cmt

  data_type: 'text'
  is_nullable: 1

=head2 dir_factor_cmt

  data_type: 'text'
  is_nullable: 1

=head2 year_last_improv_cmt

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'hpms.hpms_id_seq'

=cut

__PACKAGE__->add_columns(
  "year_record",
  { data_type => "double precision", is_nullable => 1 },
  "state_code",
  { data_type => "double precision", is_nullable => 1 },
  "route_id",
  { data_type => "text", is_nullable => 1 },
  "begin_point",
  { data_type => "double precision", is_nullable => 1 },
  "end_point",
  { data_type => "double precision", is_nullable => 1 },
  "section_length",
  { data_type => "double precision", is_nullable => 1 },
  "aadt",
  { data_type => "double precision", is_nullable => 1 },
  "aadt_combination",
  { data_type => "double precision", is_nullable => 1 },
  "aadt_single_unit",
  { data_type => "double precision", is_nullable => 1 },
  "access_control",
  { data_type => "double precision", is_nullable => 1 },
  "counter_peak_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "county_code",
  { data_type => "double precision", is_nullable => 1 },
  "dir_factor",
  { data_type => "double precision", is_nullable => 1 },
  "facility_type",
  { data_type => "double precision", is_nullable => 1 },
  "f_system",
  { data_type => "double precision", is_nullable => 1 },
  "hov_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "hov_type",
  { data_type => "double precision", is_nullable => 1 },
  "iri",
  { data_type => "double precision", is_nullable => 1 },
  "k_factor",
  { data_type => "double precision", is_nullable => 1 },
  "lane_width",
  { data_type => "double precision", is_nullable => 1 },
  "nhs",
  { data_type => "double precision", is_nullable => 1 },
  "ownership",
  { data_type => "double precision", is_nullable => 1 },
  "pct_peak_combination",
  { data_type => "double precision", is_nullable => 1 },
  "pct_peak_single",
  { data_type => "double precision", is_nullable => 1 },
  "peak_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "route_number",
  { data_type => "double precision", is_nullable => 1 },
  "route_qualifier",
  { data_type => "double precision", is_nullable => 1 },
  "route_signing",
  { data_type => "double precision", is_nullable => 1 },
  "speed_limit",
  { data_type => "double precision", is_nullable => 1 },
  "through_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "truck",
  { data_type => "double precision", is_nullable => 1 },
  "urban_code",
  { data_type => "double precision", is_nullable => 1 },
  "alternative_route_name_txt",
  { data_type => "text", is_nullable => 1 },
  "facility_type_cmt",
  { data_type => "text", is_nullable => 1 },
  "f_system_cmt",
  { data_type => "text", is_nullable => 1 },
  "iri_cmt",
  { data_type => "text", is_nullable => 1 },
  "nhs_cmt",
  { data_type => "text", is_nullable => 1 },
  "ownership_cmt",
  { data_type => "text", is_nullable => 1 },
  "urban_code_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_combination_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_single_unit_cmt",
  { data_type => "text", is_nullable => 1 },
  "county_code_cmt",
  { data_type => "text", is_nullable => 1 },
  "k_factor_cmt",
  { data_type => "text", is_nullable => 1 },
  "pct_peak_combination_cmt",
  { data_type => "text", is_nullable => 1 },
  "pct_peak_single_cmt",
  { data_type => "text", is_nullable => 1 },
  "peak_lanes_cmt",
  { data_type => "text", is_nullable => 1 },
  "through_lanes_cmt",
  { data_type => "text", is_nullable => 1 },
  "access_control_cmt",
  { data_type => "text", is_nullable => 1 },
  "dir_factor_cmt",
  { data_type => "text", is_nullable => 1 },
  "year_last_improv_cmt",
  { data_type => "text", is_nullable => 1 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "hpms.hpms_id_seq",
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 hpms_failed_geom

Type: might_have

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom>

=cut

__PACKAGE__->might_have(
  "hpms_failed_geom",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 hpms_link_geoms

Type: has_many

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom>

=cut

__PACKAGE__->has_many(
  "hpms_link_geoms",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 hpms_match_details

Type: has_many

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail>

=cut

__PACKAGE__->has_many(
  "hpms_match_details",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsMatchDetail",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-24 10:10:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:79R3YjryLsIuip1AUvFKvA
# These lines were loaded from '/usr/local/share/perl5/CalVAD/HPMS/Schema/Result/Hpms/HPMS.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package CalVAD::HPMS::Schema::Result::Hpms::HPMS;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE


use strict;
use warnings;

use base 'DBIx::Class::Core';


__PACKAGE__->table("hpms.hpms");


__PACKAGE__->add_columns(
  "year_record",
  { data_type => "double precision", is_nullable => 1 },
  "state_code",
  { data_type => "double precision", is_nullable => 1 },
  "route_id",
  { data_type => "text", is_nullable => 1 },
  "begin_point",
  { data_type => "double precision", is_nullable => 1 },
  "end_point",
  { data_type => "double precision", is_nullable => 1 },
  "section_length",
  { data_type => "double precision", is_nullable => 1 },
  "aadt",
  { data_type => "double precision", is_nullable => 1 },
  "aadt_combination",
  { data_type => "double precision", is_nullable => 1 },
  "aadt_single_unit",
  { data_type => "double precision", is_nullable => 1 },
  "access_control",
  { data_type => "double precision", is_nullable => 1 },
  "counter_peak_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "county_code",
  { data_type => "double precision", is_nullable => 1 },
  "dir_factor",
  { data_type => "double precision", is_nullable => 1 },
  "facility_type",
  { data_type => "double precision", is_nullable => 1 },
  "f_system",
  { data_type => "double precision", is_nullable => 1 },
  "hov_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "hov_type",
  { data_type => "double precision", is_nullable => 1 },
  "iri",
  { data_type => "double precision", is_nullable => 1 },
  "k_factor",
  { data_type => "double precision", is_nullable => 1 },
  "lane_width",
  { data_type => "double precision", is_nullable => 1 },
  "nhs",
  { data_type => "double precision", is_nullable => 1 },
  "ownership",
  { data_type => "double precision", is_nullable => 1 },
  "pct_peak_combination",
  { data_type => "double precision", is_nullable => 1 },
  "pct_peak_single",
  { data_type => "double precision", is_nullable => 1 },
  "peak_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "route_number",
  { data_type => "double precision", is_nullable => 1 },
  "route_qualifier",
  { data_type => "double precision", is_nullable => 1 },
  "route_signing",
  { data_type => "double precision", is_nullable => 1 },
  "speed_limit",
  { data_type => "double precision", is_nullable => 1 },
  "through_lanes",
  { data_type => "double precision", is_nullable => 1 },
  "truck",
  { data_type => "double precision", is_nullable => 1 },
  "urban_code",
  { data_type => "double precision", is_nullable => 1 },
  "alternative_route_name_txt",
  { data_type => "text", is_nullable => 1 },
  "facility_type_cmt",
  { data_type => "text", is_nullable => 1 },
  "f_system_cmt",
  { data_type => "text", is_nullable => 1 },
  "iri_cmt",
  { data_type => "text", is_nullable => 1 },
  "nhs_cmt",
  { data_type => "text", is_nullable => 1 },
  "ownership_cmt",
  { data_type => "text", is_nullable => 1 },
  "urban_code_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_combination_cmt",
  { data_type => "text", is_nullable => 1 },
  "aadt_single_unit_cmt",
  { data_type => "text", is_nullable => 1 },
  "county_code_cmt",
  { data_type => "text", is_nullable => 1 },
  "k_factor_cmt",
  { data_type => "text", is_nullable => 1 },
  "pct_peak_combination_cmt",
  { data_type => "text", is_nullable => 1 },
  "pct_peak_single_cmt",
  { data_type => "text", is_nullable => 1 },
  "peak_lanes_cmt",
  { data_type => "text", is_nullable => 1 },
  "through_lanes_cmt",
  { data_type => "text", is_nullable => 1 },
  "access_control_cmt",
  { data_type => "text", is_nullable => 1 },
  "dir_factor_cmt",
  { data_type => "text", is_nullable => 1 },
  "year_last_improv_cmt",
  { data_type => "text", is_nullable => 1 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "hpms.hpms_id_seq",
  },
);


__PACKAGE__->set_primary_key("id");


__PACKAGE__->might_have(
  "hpms_failed_geom",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


__PACKAGE__->has_many(
  "hpms_link_geoms",
  "CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-18 13:14:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2zZTaV9qCibHxfNAjWyldQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

__END__

=pod

=encoding UTF-8

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HPMS

=head1 VERSION

version 0.001

=head1 NAME

CalVAD::HPMS::Schema::Result::Hpms::HPMS

=head1 TABLE: C<hpms.hpms>

=head1 ACCESSORS

=head2 year_record

  data_type: 'double precision'
  is_nullable: 1

=head2 state_code

  data_type: 'double precision'
  is_nullable: 1

=head2 route_id

  data_type: 'text'
  is_nullable: 1

=head2 begin_point

  data_type: 'double precision'
  is_nullable: 1

=head2 end_point

  data_type: 'double precision'
  is_nullable: 1

=head2 section_length

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt_combination

  data_type: 'double precision'
  is_nullable: 1

=head2 aadt_single_unit

  data_type: 'double precision'
  is_nullable: 1

=head2 access_control

  data_type: 'double precision'
  is_nullable: 1

=head2 counter_peak_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 county_code

  data_type: 'double precision'
  is_nullable: 1

=head2 dir_factor

  data_type: 'double precision'
  is_nullable: 1

=head2 facility_type

  data_type: 'double precision'
  is_nullable: 1

=head2 f_system

  data_type: 'double precision'
  is_nullable: 1

=head2 hov_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 hov_type

  data_type: 'double precision'
  is_nullable: 1

=head2 iri

  data_type: 'double precision'
  is_nullable: 1

=head2 k_factor

  data_type: 'double precision'
  is_nullable: 1

=head2 lane_width

  data_type: 'double precision'
  is_nullable: 1

=head2 nhs

  data_type: 'double precision'
  is_nullable: 1

=head2 ownership

  data_type: 'double precision'
  is_nullable: 1

=head2 pct_peak_combination

  data_type: 'double precision'
  is_nullable: 1

=head2 pct_peak_single

  data_type: 'double precision'
  is_nullable: 1

=head2 peak_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 route_number

  data_type: 'double precision'
  is_nullable: 1

=head2 route_qualifier

  data_type: 'double precision'
  is_nullable: 1

=head2 route_signing

  data_type: 'double precision'
  is_nullable: 1

=head2 speed_limit

  data_type: 'double precision'
  is_nullable: 1

=head2 through_lanes

  data_type: 'double precision'
  is_nullable: 1

=head2 truck

  data_type: 'double precision'
  is_nullable: 1

=head2 urban_code

  data_type: 'double precision'
  is_nullable: 1

=head2 alternative_route_name_txt

  data_type: 'text'
  is_nullable: 1

=head2 facility_type_cmt

  data_type: 'text'
  is_nullable: 1

=head2 f_system_cmt

  data_type: 'text'
  is_nullable: 1

=head2 iri_cmt

  data_type: 'text'
  is_nullable: 1

=head2 nhs_cmt

  data_type: 'text'
  is_nullable: 1

=head2 ownership_cmt

  data_type: 'text'
  is_nullable: 1

=head2 urban_code_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_combination_cmt

  data_type: 'text'
  is_nullable: 1

=head2 aadt_single_unit_cmt

  data_type: 'text'
  is_nullable: 1

=head2 county_code_cmt

  data_type: 'text'
  is_nullable: 1

=head2 k_factor_cmt

  data_type: 'text'
  is_nullable: 1

=head2 pct_peak_combination_cmt

  data_type: 'text'
  is_nullable: 1

=head2 pct_peak_single_cmt

  data_type: 'text'
  is_nullable: 1

=head2 peak_lanes_cmt

  data_type: 'text'
  is_nullable: 1

=head2 through_lanes_cmt

  data_type: 'text'
  is_nullable: 1

=head2 access_control_cmt

  data_type: 'text'
  is_nullable: 1

=head2 dir_factor_cmt

  data_type: 'text'
  is_nullable: 1

=head2 year_last_improv_cmt

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'hpms.hpms_id_seq'

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=head1 RELATIONS

=head2 hpms_failed_geom

Type: might_have

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsFailedGeom>

=head2 hpms_link_geoms

Type: has_many

Related object: L<CalVAD::HPMS::Schema::Result::Hpms::HpmsLinkGeom>

=head1 AUTHOR

James E. Marca <james@activimetrics.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2015 by James E. Marca.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
# End of lines loaded from '/usr/local/share/perl5/CalVAD/HPMS/Schema/Result/Hpms/HPMS.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
