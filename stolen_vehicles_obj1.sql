use stolen_vehicles_db;

select * from locations;
select * from make_details;
select * from stolen_vehicles;

/*Objective 1
IDENTIFY WHEN VEHICLES ARE STOLEN
Your first objective is to explore the vehicle and date fields in the stolen_vehicles table to identify when vehicles tend to be stolen.
*/

-- 1. Find the number of vehicles stolen each year.
select year(date_stolen), count(vehicle_id) as num_vehicles
from stolen_vehicles
group by year(date_stolen);


-- 2. Find the number of vehicles stolen each month.
select year(date_stolen)
	 , month(date_stolen)
     , count(vehicle_id) as num_vehicles
from stolen_vehicles
group by year(date_stolen), month(date_stolen)
order by year(date_stolen), month(date_stolen);


-- 3. Find the number of vehicles stolen each day of the week.
select dayofweek(date_stolen) as dow, count(vehicle_id) as num_vehicles
from stolen_vehicles
group by dayofweek(date_stolen)
order by dayofweek(date_stolen)
;

-- 4. Replace the numeric day of week values with the full name of each day of the week (Sunday, Monday, Tuesday, etc.)
select dayofweek(date_stolen) as dow
	 , case when dayofweek(date_stolen) = 1 then 'Sunday'
		    when dayofweek(date_stolen) = 2 then 'Monday'
            when dayofweek(date_stolen) = 3 then 'Tuesday'
            when dayofweek(date_stolen) = 4 then 'Wednesday'
            when dayofweek(date_stolen) = 5 then 'Thursday'
            when dayofweek(date_stolen) = 6 then 'Friday'
            else 'Saturday'
            end as day_of_week
	 , count(vehicle_id) as num_vehicles
from stolen_vehicles
group by dayofweek(date_stolen), day_of_week
order by dow
;

-- 5. Create a bar chart that shows the number of vehicles stolen on each day of the week.   Export data to excel from task 4







