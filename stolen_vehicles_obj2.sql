use stolen_vehicles_db;
/* Objective 2
Your second objective is to explore the vehicle type, age, luxury vs standard and color fields in the stolen_vehicles table to identify which vehicles are most likely to be stolen.
*/

-- 1. Find the vehicle types that are most often and least often stolen.
select * from stolen_vehicles;

-- most often stolen
select vehicle_type, count(vehicle_id) as num_vehicles
from stolen_vehicles
group by vehicle_type
order by num_vehicles desc
limit 5
;
-- least often stolen
select vehicle_type, count(vehicle_id) as num_vehicles
from stolen_vehicles
group by vehicle_type
order by num_vehicles 
limit 5
;


-- 2. For each vehicle type, find the average age of the cars that are stolen.
select vehicle_type, avg(year(date_stolen) - model_year) as avg_age
from stolen_vehicles
group by vehicle_type
order by avg_age desc
;


-- 3. For each vehicle type, find the percent of vehicles stolen that are luxury versus standard.
select * from make_details;

with lux_standard as (select sv.vehicle_type
							 , case when make_type = 'Luxury' then 1 else 0 end as luxury
							 , 1 as all_cars
						from stolen_vehicles sv left join make_details md
							on sv.make_id = md.make_id)
select vehicle_type, sum(luxury) / sum(all_cars) * 100 as pct_lux
from lux_standard
group by vehicle_type
order by pct_lux desc
;					

-- 4. Create a table where the rows represent the top 10 vehicles types, the columns represent the top 7 vehicle colors (plus 1 column for all the other colors) and the values are the number of vehicles stolen.
select * from stolen_vehicles;

'Silver', '1272'
'White', '934'
'Black', '589'
'Blue', '512'
'Red', '390'
'Grey',	'378'
'Green', '224'
'Other'

select color, count(vehicle_id) as num_vehicles
from stolen_vehicles
group by color
order by num_vehicles desc;

select vehicle_type
	, count(vehicle_id) as num_vehicles
	, sum(case when color = 'Silver' then 1 else 0 end) as silver
	, sum(case when color = 'White' then 1 else 0 end) as white
	, sum(case when color = 'Black' then 1 else 0 end) as black
    , sum(case when color = 'Blue' then 1 else 0 end) as Blue
    , sum(case when color = 'Red' then 1 else 0 end) as red
    , sum(case when color = 'Grey' then 1 else 0 end) as grey
    , sum(case when color = 'Green' then 1 else 0 end) as green
    , sum(case when color IN('Gold', 'Brown', 'Yellow', 'Orange', 'Purple', 'Cream', 'Pink') then 1 else 0 end) as other_colors
from stolen_vehicles  
group by vehicle_type
order by num_vehicles desc
limit 10;
  
  
-- 5. Create a heat map of the table comparing the vehicle types and colors.  Export to excel from task 4
