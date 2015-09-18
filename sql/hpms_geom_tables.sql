create schema hpms;

drop table if exists hpms.hpms_geom cascade;
create table hpms.hpms_geom(
    id serial primary key
);

SELECT AddGeometryColumn('hpms', 'hpms_geom', 'geom', 4326, 'LINESTRING', 2);


drop table if exists hpms.hpms_link_geom cascade;
create table hpms.hpms_link_geom(
    geo_id  integer not null references hpms.hpms_geom(id) on delete cascade,
    hpms_id integer not null references hpms.hpms(id) on delete cascade,
    direction text,
    unique (hpms_id,direction)
);


drop table if exists hpms.hpms_failed_geom cascade;
create table hpms.hpms_failed_geom(
    hpms_id integer not null references hpms.hpms(id) on delete cascade,
    primary key (hpms_id)
);
