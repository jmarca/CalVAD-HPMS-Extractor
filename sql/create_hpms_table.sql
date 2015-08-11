--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hpms; Type: TABLE; Schema: public; Owner: slash; Tablespace: 
--

CREATE TABLE hpms (
    year text,
    year_record double precision,
    state_code double precision,
    route_id text,
    begin_point double precision,
    end_point double precision,
    section_length double precision,
    aadt double precision,
    aadt_combination double precision,
    aadt_single_unit double precision,
    access_control double precision,
    counter_peak_lanes double precision,
    county_code double precision,
    dir_factor double precision,
    facility_type double precision,
    f_system double precision,
    hov_lanes double precision,
    hov_type double precision,
    iri double precision,
    k_factor double precision,
    lane_width double precision,
    nhs double precision,
    ownership double precision,
    pct_peak_combination double precision,
    pct_peak_single double precision,
    peak_lanes double precision,
    route_number double precision,
    route_qualifier double precision,
    route_signing double precision,
    speed_limit double precision,
    through_lanes double precision,
    truck double precision,
    urban_code double precision,
    alternative_route_name_txt text,
    alternative_route_name boolean,
    year_last_improv boolean,
    facility_type_cmt text,
    f_system_cmt text,
    iri_cmt text,
    nhs_cmt text,
    ownership_cmt text,
    urban_code_cmt text,
    aadt_cmt text,
    aadt_combination_cmt text,
    aadt_single_unit_cmt text,
    county_code_cmt text,
    k_factor_cmt text,
    pct_peak_combination_cmt text,
    pct_peak_single_cmt text,
    peak_lanes_cmt text,
    through_lanes_cmt text,
    access_control_cmt text,
    dir_factor_cmt text,
    year_last_improv_cmt text
);


ALTER TABLE hpms OWNER TO slash;

--
-- PostgreSQL database dump complete
--

