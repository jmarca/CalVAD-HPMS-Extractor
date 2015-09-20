--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE schema hpms;

SET search_path = hpms, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hpms; Type: TABLE; Schema: hpms; Owner: slash; Tablespace:
--

CREATE TABLE hpms (
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
    year_last_improv_cmt text,
    id integer NOT NULL
);


ALTER TABLE hpms OWNER TO slash;

--
-- Name: hpms_failed_geom; Type: TABLE; Schema: hpms; Owner: slash; Tablespace:
--

CREATE TABLE hpms_failed_geom (
    hpms_id integer NOT NULL
);


ALTER TABLE hpms_failed_geom OWNER TO slash;

--
-- Name: hpms_geom; Type: TABLE; Schema: hpms; Owner: slash; Tablespace:
--

CREATE TABLE hpms_geom (
    id integer NOT NULL,
    geom public.geometry(LineString,4326)
);


ALTER TABLE hpms_geom OWNER TO slash;

--
-- Name: hpms_geom_id_seq; Type: SEQUENCE; Schema: hpms; Owner: slash
--

CREATE SEQUENCE hpms_geom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hpms_geom_id_seq OWNER TO slash;

--
-- Name: hpms_geom_id_seq; Type: SEQUENCE OWNED BY; Schema: hpms; Owner: slash
--

ALTER SEQUENCE hpms_geom_id_seq OWNED BY hpms_geom.id;


--
-- Name: hpms_id_seq; Type: SEQUENCE; Schema: hpms; Owner: slash
--

CREATE SEQUENCE hpms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hpms_id_seq OWNER TO slash;

--
-- Name: hpms_id_seq; Type: SEQUENCE OWNED BY; Schema: hpms; Owner: slash
--

ALTER SEQUENCE hpms_id_seq OWNED BY hpms.id;


--
-- Name: hpms_link_geom; Type: TABLE; Schema: hpms; Owner: slash; Tablespace:
--

CREATE TABLE hpms_link_geom (
    geo_id integer NOT NULL,
    hpms_id integer NOT NULL,
    direction text
);


ALTER TABLE hpms_link_geom OWNER TO slash;

--
-- Name: id; Type: DEFAULT; Schema: hpms; Owner: slash
--

ALTER TABLE ONLY hpms ALTER COLUMN id SET DEFAULT nextval('hpms_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: hpms; Owner: slash
--

ALTER TABLE ONLY hpms_geom ALTER COLUMN id SET DEFAULT nextval('hpms_geom_id_seq'::regclass);


--
-- Name: hpms_failed_geom_pkey; Type: CONSTRAINT; Schema: hpms; Owner: slash; Tablespace:
--

ALTER TABLE ONLY hpms_failed_geom
    ADD CONSTRAINT hpms_failed_geom_pkey PRIMARY KEY (hpms_id);


--
-- Name: hpms_geom_pkey; Type: CONSTRAINT; Schema: hpms; Owner: slash; Tablespace:
--

ALTER TABLE ONLY hpms_geom
    ADD CONSTRAINT hpms_geom_pkey PRIMARY KEY (id);


--
-- Name: hpms_link_geom_hpms_id_direction_key; Type: CONSTRAINT; Schema: hpms; Owner: slash; Tablespace:
--

ALTER TABLE ONLY hpms_link_geom
    ADD CONSTRAINT hpms_link_geom_hpms_id_direction_key UNIQUE (hpms_id, direction);


--
-- Name: hpms_pkey; Type: CONSTRAINT; Schema: hpms; Owner: slash; Tablespace:
--

ALTER TABLE ONLY hpms
    ADD CONSTRAINT hpms_pkey PRIMARY KEY (id);


--
-- Name: hpms_failed_geom_hpms_id_fkey; Type: FK CONSTRAINT; Schema: hpms; Owner: slash
--

ALTER TABLE ONLY hpms_failed_geom
    ADD CONSTRAINT hpms_failed_geom_hpms_id_fkey FOREIGN KEY (hpms_id) REFERENCES hpms(id) ON DELETE CASCADE;


--
-- Name: hpms_link_geom_geo_id_fkey; Type: FK CONSTRAINT; Schema: hpms; Owner: slash
--

ALTER TABLE ONLY hpms_link_geom
    ADD CONSTRAINT hpms_link_geom_geo_id_fkey FOREIGN KEY (geo_id) REFERENCES hpms_geom(id) ON DELETE CASCADE;


--
-- Name: hpms_link_geom_hpms_id_fkey; Type: FK CONSTRAINT; Schema: hpms; Owner: slash
--

ALTER TABLE ONLY hpms_link_geom
    ADD CONSTRAINT hpms_link_geom_hpms_id_fkey FOREIGN KEY (hpms_id) REFERENCES hpms(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
