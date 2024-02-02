/*DROP TABLE locations;
DROP TABLE vaccine;
DROP TABLE vaccination_stat;
DROP TABLE vaccinations_by_age_group;
DROP TABLE vaccinations_by_location;
DROP TABLE vaccinations_by_vaccine;*/
----------------------------------------------------------------
CREATE TABLE locations (
    location         TEXT    NOT NULL,
    total_population INTEGER,
    PRIMARY KEY (location)
)
WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE vaccine (
    vaccines TEXT NOT NULL,
    PRIMARY KEY (vaccines)
)WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE age_group (
    age_group TEXT NOT NULL,
    PRIMARY KEY (age_group)
)WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE vaccinations_by_location (
    location              TEXT NOT NULL,
    vaccines              TEXT NOT NULL,
    last_observation_date TEXT,
    source_name           TEXT,
    source_url            TEXT,
    PRIMARY KEY (vaccines, location),
    FOREIGN KEY (location) REFERENCES locations (location),
    FOREIGN KEY (vaccines) REFERENCES vaccine (vaccines) 
)WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE vaccinations_by_vaccine (
    location                TEXT    NOT NULL,
    date                    TEXT    NOT NULL,
    vaccine                 TEXT    NOT NULL,
    source_url              TEXT    NOT NULL,
    total_vaccinations      INTEGER,
    people_vaccinated       INTEGER,
    people_fully_vaccinated INTEGER,
    total_boosters          INTEGER,
    PRIMARY KEY (location, date, vaccine, source_url),
    FOREIGN KEY (location)
    REFERENCES locations (location),
    FOREIGN KEY (vaccine)
    REFERENCES vaccine (vaccines) 
)WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE vaccination_stat (
    location                              TEXT    NOT NULL,
    date                                  TEXT    NOT NULL,
    total_vaccinations                    INTEGER,
    people_vaccinated                     INTEGER,
    people_fully_vaccinated               INTEGER,
    total_boosters                        INTEGER,
    daily_vaccinations                    INTEGER,
    daily_people_vaccinated               INTEGER,
    avg_of_daily_vaccination_each_country INTEGER,
    PRIMARY KEY (location, date),
    FOREIGN KEY (location)
    REFERENCES locations (location) 
)WITHOUT ROWID;

----------------------------------------------------------------
CREATE TABLE vaccinations_by_age_group (
    location                            TEXT    NOT NULL,
    date                                TEXT    NOT NULL,
    age_group                           TEXT    NOT NULL,
    people_vaccinated_per_hundred       INTEGER,
    people_fully_vaccinated_per_hundred INTEGER,
    people_with_booster_per_hundred     INTEGER,
    PRIMARY KEY (location,date,age_group),
    FOREIGN KEY (location) REFERENCES locations (location), 
    FOREIGN KEY (age_group) REFERENCES age_group (age_group)
)WITHOUT ROWID;
