-- Viewing entire
select * 
from project1;

-- Total electricity use in 2010
select sum(total) 
from project1;

-- Total consumption by neighbourhood
select 
sub.community_area_name,
sub.community_total,
cast(cast(sub.community_total as dec(2,0))/cast(sum(sub.community_total) as dec(2,0)) as dec(2,0)) as perc
from (
select community_area_name, 
       sum(total) as community_total 
from project1
group by community_area_name) sub
group by sub.community_area_name, sub.community_total
order by perc desc;

-- Total consumption by building type
select building_type, sum(total) as building_total
from project1
group by building_type
order by building_total desc;

-- Total consumption by building sub type
select building_subtype, sum(total) as building_sub_total
from project1
group by building_subtype
order by building_sub_total desc;

