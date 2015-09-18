use utf8;
package CalVAD::HPMS::Schema::Result::HPMS::HPMS;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CalVAD::HPMS::Schema::Result::HPMS::HPMS

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<hpms>

=cut

__PACKAGE__->table("hpms");

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

Related object: L<CalVAD::HPMS::Schema::Result::HPMS::HPMSFailedGeom>

=cut

__PACKAGE__->might_have(
  "hpms_failed_geom",
  "CalVAD::HPMS::Schema::Result::HPMS::HPMSFailedGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 hpms_link_geoms

Type: has_many

Related object: L<CalVAD::HPMS::Schema::Result::HPMS::HPMSLinkGeom>

=cut

__PACKAGE__->has_many(
  "hpms_link_geoms",
  "CalVAD::HPMS::Schema::Result::HPMS::HPMSLinkGeom",
  { "foreign.hpms_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-09-17 18:41:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s9bFpkasHvn4JCMWnctVmQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
