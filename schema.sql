-- Table reset
drop table if exists trip;
drop table if exists reservation;
drop table if exists schedule;
drop table if exists boat;
drop table if exists location_;
drop type if exists locType;
drop table if exists sailor;
drop table if exists owner_;
drop table if exists person;
drop table if exists country;

-- Schema Creation
CREATE TABLE country(
    country_name   VARCHAR(20) NOT NULL,
    iso_code       VARCHAR(20) NOT NULL,
    flag           VARCHAR(20) NOT NULL,
    UNIQUE(country_name, flag), -- IC5 and IC4
    PRIMARY KEY(iso_code));

CREATE TABLE person(
    person_ID          INTEGER NOT NULL,
    person_country     VARCHAR(20) NOT NULL,
    person_name        VARCHAR(20) NOT NULL,
    PRIMARY KEY(person_ID, person_country),
    FOREIGN KEY(person_country) REFERENCES country(iso_code));

CREATE TABLE sailor(
    sailor_ID          INTEGER NOT NULL,
    sailor_country     VARCHAR(20) NOT NULL,
    PRIMARY KEY(sailor_ID, sailor_country),
    FOREIGN KEY(sailor_ID, sailor_country) REFERENCES person(person_ID, person_country));

CREATE TABLE owner_(
    owner_ID           INTEGER NOT NULL,
    owner_country      VARCHAR(20) NOT NULL,
    owner_birthday     DATE NOT NULL,
    PRIMARY KEY(owner_ID, owner_country),
    FOREIGN KEY(owner_ID, owner_country) REFERENCES person(person_ID, person_country));

-- Any location can only be of 1 of these types at a time
CREATE TYPE locType AS ENUM ('marina', 'warf', 'port');

CREATE TABLE location_(
    location_country    VARCHAR(20) NOT NULL,
    location_name       VARCHAR(20) NOT NULL,
    location_latitude   NUMERIC(8,6) NOT NULL,
    location_longitude  NUMERIC(9,6) NOT NULL,
    location_type       locType NOT NULL,
    PRIMARY KEY(location_latitude, location_longitude),
    FOREIGN KEY(location_country) REFERENCES country(iso_code)
    -- Constraint IC3
    -- A location must be separate from other locations, at least one mile apart
    );

CREATE TABLE boat(
    boat_cni           VARCHAR(20) NOT NULL,
    boat_year          INTEGER NOT NULL,
    boat_country       VARCHAR(20) NOT NULL,
    boat_name          VARCHAR(20) NOT NULL,
    boat_length        NUMERIC(5,2) NOT NULL,
    boat_radio_mmsi    VARCHAR(20),
    boat_owner_id      INTEGER NOT NULL,
    boat_owner_country VARCHAR(20) NOT NULL,
    UNIQUE (boat_radio_mmsi),
    PRIMARY KEY(boat_cni, boat_country),
    FOREIGN KEY(boat_country) REFERENCES country(iso_code),
    FOREIGN KEY(boat_owner_id, boat_owner_country)  REFERENCES owner_(owner_ID, owner_country));

CREATE TABLE schedule(
    start_date      DATE NOT NULL,
    end_date        DATE NOT NULL,
    PRIMARY KEY(start_date, end_date),
    CONSTRAINT date_check CHECK (end_date > start_date)); -- Constraint IC6

CREATE TABLE reservation(
    reservation_start_date         DATE NOT NULL,
    reservation_end_date           DATE NOT NULL,
    reservation_boat               VARCHAR(20) NOT NULL,
    reservation_boat_country       VARCHAR(20) NOT NULL,
    reservation_sailor             INTEGER NOT NULL,
    reservation_sailor_country     VARCHAR(20) NOT NULL,

    PRIMARY KEY(reservation_start_date, reservation_end_date, reservation_boat, reservation_boat_country,
                reservation_sailor, reservation_sailor_country),
    FOREIGN KEY(reservation_start_date, reservation_end_date) REFERENCES schedule(start_date, end_date),
    FOREIGN KEY(reservation_boat, reservation_boat_country)	REFERENCES boat(boat_cni, boat_country),
    FOREIGN KEY(reservation_sailor, reservation_sailor_country)	REFERENCES sailor(sailor_ID, sailor_country)
    -- Constraint IC1
    -- If a boat is already booked for the wanted dates, the reservation shall fail
    );

CREATE TABLE trip(
    trip_date                      DATE NOT NULL,
    trip_duration                  INTEGER NOT NULL,
    trip_boat                      VARCHAR(20) NOT NULL,
    trip_boat_country              VARCHAR(20) NOT NULL,
    trip_sailor                    INTEGER NOT NULL,
    trip_sailor_country            VARCHAR(20) NOT NULL,
    reservation_start_date         DATE NOT NULL,
    reservation_end_date           DATE NOT NULL,
    start_lat                      NUMERIC(8,6) NOT NULL,
    start_long                     NUMERIC(9,6) NOT NULL,
    end_lat                        NUMERIC(8,6) NOT NULL,
    end_long                       NUMERIC(9,6) NOT NULL,

    PRIMARY KEY(trip_date, trip_boat, trip_boat_country, trip_sailor, trip_sailor_country,
                reservation_start_date, reservation_end_date),
    FOREIGN KEY(trip_boat, trip_boat_country, trip_sailor, trip_sailor_country, reservation_start_date,
                reservation_end_date)
        REFERENCES reservation(reservation_boat, reservation_boat_country, reservation_sailor, reservation_sailor_country,
                               reservation_start_date, reservation_end_date),
    FOREIGN KEY(start_lat, start_long) REFERENCES location_(location_latitude, location_longitude),
    FOREIGN KEY(end_lat, end_long) REFERENCES location_(location_latitude, location_longitude),
    CONSTRAINT duration_check CHECK (trip_duration > 0),
    CONSTRAINT start_date_check CHECK (trip_date >= reservation_start_date),
    CONSTRAINT end_date_check CHECK (trip_date + trip_duration <= reservation_end_date));
    -- Constraint IC2
    -- If the new trip overlaps with an existing trip in the reservation, the trip shall fail


	
