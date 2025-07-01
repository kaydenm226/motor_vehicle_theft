/*OBJECTIVE 3
Your third objective is to explore the population and density statistics in the regions table to identify where vehicles are getting stolen, and visualize the results using a scatter plot and map.
*/

-- 1. Find the number of vehicles that were stolen in each region.
select * from stolen_vehicles;
select * from locations;

select l.region
	,  count(sv.vehicle_id) as num_vehicles 
from stolen_vehicles sv left join locations l
	 on sv.location_id = l.location_id
group by l.region
;

-- 2. Combine the previous output with the population and density statistics for each region.
select l.region
	, count(sv.vehicle_id) as num_vehicles 
    , l.population
    , l.density
from stolen_vehicles sv left join locations l
	 on sv.location_id = l.location_id
group by l.region, l.population, l.density
order by num_vehicles desc
;


-- 3. Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions?
select l.region
	, count(sv.vehicle_id) as num_vehicles 
    , l.population
    , l.density
from stolen_vehicles sv left join locations l
	 on sv.location_id = l.location_id
group by l.region, l.population, l.density
order by l.density desc
;

'Auckland',	'1638',	'1695200',	'343.09'
'Nelson', '92',	'54500', '129.15'
'Wellington','420',	'543500', '67.52'

'Otago', '139', '246000', '7.89'
'Gisborne', '176', '52100', '6.21'
'Southland', '26', '102400', '3.28'
;

(select 'High_density', sv.vehicle_type
	, count(sv.vehicle_id) as num_vehicles
from stolen_vehicles sv left join locations l
	 on sv.location_id = l.location_id
where l.region in('Otago', 'Gisborne', 'Southland')
group by sv.vehicle_type
order by num_vehicles desc
limit 5)

UNION

(select 'Low_density', sv.vehicle_type
	, count(sv.vehicle_id) as num_vehicles
from stolen_vehicles sv left join locations l
	 on sv.location_id = l.location_id
where l.region in('Auckland', 'Nelson', 'Wellington')
group by sv.vehicle_type
order by num_vehicles desc
limit 5)
;

-- 4. Create a scatter plot of population versus density, and change the size of the points based on the number of vehicles stolen in each region.
-- task 2. data

-- 5. Create a map of the regions and color the regions based on the number of stolen vehicles.
