-- Viewing the data

-- Contains electricity consumption information
select * 
from project1;

-- Contains gas consumption information
select * 
from gasconsumption;

-- Contains housing information and other attributes such as population
select * 
from buildinginfo;

-- Total electricity use (10^6 kWh) in 2010
select sum(total)/1000000 as total_elecricity
from project1;

-- Total therms of gas used in 2010
select sum(total) as total_gas
from gasconsumption;

-- Total consumption and % of total consumption by neighbourhood
select 
sub.community_area_name,
sub.community_total,
cast(sub.community_total as numeric(15,3))/(select sum(total) from project1) as perc
from (
select community_area_name, 
       sum(total) as community_total 
from project1
group by community_area_name) sub
group by sub.community_area_name, sub.community_total
order by perc desc;

-- Average total population by community area
select avg(sub.total_population) as overall_avg_pop
from(
select community_area_name,
       sum(population) as total_population
from buildinginfo
group by community_area_name)sub;

-- Total consumption and % of total consumption by building type
select 
sub.building_type,
sub.building_total,
cast(sub.building_total as numeric(20,3))/(select sum(total) from project1) as perc
from (
select building_type, 
       sum(total) as building_total 
from project1
group by building_type) sub
group by sub.building_type, sub.building_total
order by perc desc;

-- Total consumption and % of total consumption by building sub-type
select 
sub.building_subtype,
sub.building_subtotal,
cast(sub.building_subtotal as numeric(20,3))/(select sum(total) from project1) as perc
from (
select building_subtype, 
       sum(total) as building_subtotal 
from project1
group by building_subtype) sub
group by sub.building_subtype, sub.building_subtotal
order by perc desc;


-- Total monthly consumption (in 10^6 KWh) trend
select sum(jan)/1000000 as jan, sum(feb)/1000000 as feb, sum(mar)/1000000 as mar,
       sum(apr)/1000000 as apr, sum(may)/1000000 as may, sum(jun)/1000000 as jun,
	   sum(jul)/1000000 as jul, sum(aug)/1000000 as aug, sum(sep)/1000000 as sep,
	   sum(oct)/1000000 as oct, sum(nov)/1000000 as nov, sum(dec)/1000000 as dec
from project1

-- Total quarterly consumption(in 10^6 KWh) trend
select sum(jan+feb+mar)/1000000 as Q1,
       sum(apr+may+jun)/1000000 as Q2,
	   sum(jul+aug+sep)/1000000 as Q3,
	   sum(oct+nov+dec)/1000000 as Q4
from project1

