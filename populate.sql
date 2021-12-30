delete from trip;
delete from reservation;
delete from schedule; 
delete from boat; 
delete from location_;
delete from owner_;
delete from sailor; 
delete from person; 
delete from country;
-----------------------
-- Populate tables
-----------------------

-- Populate country 
insert into country values ('Portugal', 'PRT', 'portugal');
insert into country values ('Spain', 'ESP', 'spain');
insert into country values ('France', 'FRA', 'france');
insert into country values ('Netherlands', 'NLD', 'netherlands');
insert into country values ('South Africa', 'ZAF', 'south africa');

-- Populate person
insert into person values ('1', 'PRT', 'Miguel Carreiro');
insert into person values ('2', 'PRT', 'Diogo Ribeiro');
insert into person values ('3', 'FRA', 'Jean Pierre');
insert into person values ('4', 'PRT', 'Duarte Honrado');
insert into person values ('5', 'NLD', 'Max Verstappen');
insert into person values ('6', 'PRT', 'João Rendeiro');

-- Populate sailor
insert into sailor values ('1', 'PRT');
insert into sailor values ('2', 'PRT');
insert into sailor values ('4', 'PRT');

-- Populate owner_
insert into owner_ values ('1', 'PRT', '14-10-1999');
insert into owner_ values ('2', 'PRT', '16-10-1999');
insert into owner_ values ('3', 'FRA', '23-04-1970');
insert into owner_ values ('5', 'NLD', '30-09-1997');
insert into owner_ values ('6', 'PRT', '20-10-1980');

-- Populate location_ 
insert into location_ values ('PRT', 'Marina Lisboa', '38.736946', '-9.142685', 'marina');
insert into location_ values ('PRT', 'Porto Açores', '38.305542', '-30.384108', 'port');
insert into location_ values ('FRA', 'France Warf', '48.864716', '48.864716', 'warf');
insert into location_ values ('ZAF', 'South Africa Port', '-26.195246', '28.034088', 'port');

-- Populate boat 
insert into boat values ('PRT1', '2020', 'PRT', 'Mercedes', '150', 'MMSI1', '1', 'PRT');
insert into boat values ('PRT2', '2000', 'PRT', 'Mário Jorge', '20', NULL, '6', 'PRT');
insert into boat values ('FRA1', '1980', 'FRA', 'Baguette', '87', 'MMSI2', '3', 'FRA');
insert into boat values ('NLD1', '2010', 'NLD', 'Red Bull', '100', 'MMSI3', '5', 'NLD');
insert into boat values ('ZAF1', '2010', 'ZAF', 'Alpha Tauri', '100', 'MMSI4', '6', 'PRT');
insert into boat values ('ZAF2', '2021', 'ZAF', 'Williams', '50', NULL, '5', 'NLD');
insert into boat values ('PRT2', '2000', 'FRA', 'Ferrari', '20', NULL, '6', 'PRT');
insert into boat values ('ZAF2', '2021', 'PRT', 'Haas', '50', NULL, '5', 'NLD');


-- Populate schedule
insert into schedule values ('14-10-2022', '18-10-2022');
insert into schedule values ('29-12-2021', '15-01-2022');
insert into schedule values ('07-05-2023', '23-11-2023');
insert into schedule values ('07-05-2010', '09-05-2010');

-- Populate reservation
insert into reservation values ('14-10-2022', '18-10-2022', 'NLD1', 'NLD', '1', 'PRT');
insert into reservation values ('29-12-2021', '15-01-2022', 'FRA1', 'FRA', '2', 'PRT');
insert into reservation values ('07-05-2023', '23-11-2023', 'PRT1', 'PRT', '2', 'PRT');
insert into reservation values ('07-05-2010', '09-05-2010', 'PRT2', 'PRT', '4', 'PRT');

-- Populate trip
insert into trip values ('14-10-2022', '4', 'NLD1', 'NLD', '1', 'PRT', '14-10-2022', '18-10-2022',
                        '38.736946', '-9.142685', '38.305542', '-30.384108');
insert into trip values ('07-05-2023', '50', 'PRT1', 'PRT', '2', 'PRT', '07-05-2023', '23-11-2023',
                        '38.305542', '-30.384108', '48.864716', '48.864716');
insert into trip values ('01-06-2023', '30', 'PRT1', 'PRT', '2', 'PRT', '07-05-2023', '23-11-2023',
                        '48.864716', '48.864716', '38.736946', '-9.142685');

