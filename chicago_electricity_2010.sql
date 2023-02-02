-- Viewing the data

-- Contains electricity consumption information
SELECT * 
FROM project1;

-- Contains gas consumption information
SELECT * 
FROM gasconsumption;

-- Contains housing information and other attributes such as population
SELECT * 
FROM buildinginfo;

-- Total electricity use (10^6 kWh) in 2010
SELECT SUM(total)/1000000 AS total_elecricity
FROM project1;

-- Total therms of gas used in 2010
SELECT SUM(total) AS total_gas
FROM gasconsumption;

-- Total consumption and % of total consumption by neighbourhood
SELECT 
sub.community_area_name,
sub.community_total,
CAST(sub.community_total AS numeric(15,3))/(SELECT SUM(total) FROM project1) AS perc
FROM (
SELECT community_area_name, 
       SUM(total) AS community_total 
FROM project1
GROUP BY community_area_name) sub
GROUP BY sub.community_area_name, sub.community_total
ORDER BY perc DESC;

-- Average total population per community area
SELECT AVG(sub.total_population) AS overall_avg_pop
FROM(
SELECT community_area_name,
       SUM(population) AS total_population
FROM buildinginfo
GROUP BY community_area_name)sub;

-- Create a flag for community areas with above and below average population. 
-- Get a count of communities with population above and below average
SELECT sub2.population_flag,
       COUNT(sub2.community_area_name) AS count_community_area_name
FROM(
SELECT sub.community_area_name, sub.community_total, 
CASE
 WHEN sub.community_total >= AVG(sub.community_total) THEN 'Above average'
 WHEN sub.community_total < AVG(sub.community_total) THEN 'Below average'
END population_flag
FROM(
SELECT community_area_name,
       SUM(population) AS community_total
FROM buildinginfo
GROUP BY community_area_name)sub
GROUP BY sub.community_area_name, sub.community_total) sub2
GROUP BY sub2.population_flag;


-- Total consumption and % of total consumption by building type
SELECT
sub.building_type,
sub.building_total,
CAST(sub.building_total AS numeric(20,3))/(SELECT SUM(total) FROM project1) AS perc
FROM (
FROM building_type, 
       SUM(total) AS building_total 
FROM project1
GROUP BY building_type) sub
GROUP BY sub.building_type, sub.building_total
ORDER BY perc DESC;

-- Total consumption and % of total consumption by building sub-type
SELECT 
sub.building_subtype,
sub.building_subtotal,
CAST(sub.building_subtotal AS numeric(20,3))/(SELECT SUM(total) FROM project1) AS perc
FROM (
SELECT building_subtype, 
       SUM(total) AS building_subtotal 
FROM project1
GROUP BY building_subtype) sub
GROUP BY sub.building_subtype, sub.building_subtotal
ORDER BY perc DESC;


-- Total monthly consumption (in 10^6 KWh) trend
SELECT SUM(jan)/1000000 AS jan, SUM(feb)/1000000 AS feb, SUM(mar)/1000000 AS mar,
       SUM(apr)/1000000 AS apr, SUM(may)/1000000 AS may, SUM(jun)/1000000 AS jun,
	   SUM(jul)/1000000 AS jul, SUM(aug)/1000000 AS aug, SUM(sep)/1000000 AS sep,
	   SUM(oct)/1000000 AS oct, SUM(nov)/1000000 AS nov, SUM(dec)/1000000 AS dec
FROM project1

-- Total quarterly consumption(in 10^6 KWh) trend
SELECT SUM(jan+feb+mar)/1000000 AS Q1,
       SUM(apr+may+jun)/1000000 AS Q2,
	   SUM(jul+aug+sep)/1000000 AS Q3,
	   SUM(oct+nov+dec)/1000000 AS Q4
FROM project1

