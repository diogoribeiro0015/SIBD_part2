-- A. All boats that have been reserved at least once
select distinct b as Boat
from boat b
    join reservation r on b.boat_cni = r.reservation_boat
where b.boat_cni like r.reservation_boat and b.boat_country like r.reservation_boat_country;

-- B. All sailors that have reserved boats registered in the country 'Portugal'
select p AS Sailor
from person p
    join sailor s on p.person_ID = s.sailor_ID
    join reservation r on s.sailor_ID = r.reservation_sailor
    join country cn on r.reservation_boat_country = cn.iso_code
where cn.country_name LIKE 'Portugal';

-- C. All reservations longer than 5 days
select reservation
from reservation
where (reservation_end_date::date - reservation_start_date::date) >= 5;

-- D. Name and CNI of all boats registered in 'South Africa' whose owner name ends with 'Rendeiro'
select boat_cni, boat_name
from boat b
    join owner_ o on b.boat_owner_id = o.owner_id
    join person p on o.owner_id = p.person_id
    join country cn on b.boat_country = cn.iso_code
where cn.country_name like 'South Africa' and p.person_name like '% Rendeiro';