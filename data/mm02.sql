-- Metro STR permits are good for one year. We do not know the date on which they expired, but we do know if they are expired.
-- Renewed permits do not receive a new permit number, they are simply extended one more year.
-- Assume that permits in ISSUED status are and will be renewed timely indefinitely. We can adjust for average length of current active permits later if we want.
-- Assume that permits that are EXPIRED were renewed each year as long as there is a subsequent permit issued at some point for the same location.
-- If no subsequent permit, assume that the EXPIRED permit expired at the end of the first year.
-- Drop permits that do not have an issue date since we are interested at this point in permits over time. All of the permits w/o issue date are EXPIRED in the db.
-- Include the location text for now because in a multi-unit apn, the location includes the unit #. May drop all of these later, not sure.
-- Ultimately trying to get to number of permits/renewals per unique apn/location by zip code over time.

with years as 
	(select distinct extract(year from dateissued) as yearactive
	 	from permit 
	 	where permittype = 'RESIDENTIAL SHORT TERM RENTAL'
	 	and dateissued is not null
	),
	strpermits as 
	(select apn || '|' || pm.location || '|' || permitsubtype as apnkey,
	 	apn, 
		permitnumber, 
		"location", 
		permitsubtype,
		-- contractor,
		status, 
		dateissued,
		extract(year from dateissued) as yearactive,
		(dateissued + interval '1 year')::timestamp::date as renewaldate,
	 	case when status = 'EXPIRED' 
			then coalesce(
					lead(dateissued,1) over (
					partition by apn, "location"
					order by dateissued),
				 	(dateissued + interval '1 year')::timestamp::date
				)	 
				else '2099-12-31' end as expirydate,
		case when status = 'EXPIRED' then 0 else 1 end as wasrenewed
		from permit pm
		where permittype = 'RESIDENTIAL SHORT TERM RENTAL' 
			and dateissued is not null
			and status in ('ISSUED', 'EXPIRED')
			--and apn = '041010A07800CO'
		order by apn, dateissued, status),
	apnlocyear as
	(select distinct y.yearactive, str.apnkey
			from years y
			cross join strpermits str),
	zips as
	(select distinct apn, propzip from property)
select z.propzip, ay.yearactive, str.apn, str.permitnumber, str.location,
	str.permitsubtype, str.status, str.dateissued, str.expirydate, str.renewaldate
	from apnlocyear ay
	left join strpermits str on ay.apnkey = str.apnkey
	left join zips z on z.apn = str.apn
	where ay.yearactive >= str.yearactive and ay.yearactive < extract(year from expirydate)
	order by ay.apnkey, ay.yearactive, str.dateissued;

/***********************EXPLORATORY*SCRATCHPAD*BELOW*****************************************************************/
select apn, count(*) from property
group by apn
having count(*) > 1;

select * from property limit 50;

select * from permit limit 50;
select permittype, permitsubtype, count(*), min(dateissued), max(dateissued)
	from permit
	where permittype not like '%COMMERCIAL%'
	group by permittype, permitsubtype;
	
select permitsubtype, min(dateissued), max(dateissued), count(*)
	from permit
	where permittype = 'RESIDENTIAL SHORT TERM RENTAL'
	group by permitsubtype;
	
select per.apn, permitsubtype, dateissued, prop.*
	from permit per
	join property prop on per.apn = prop.apn
	where permittype = 'RESIDENTIAL SHORT TERM RENTAL'
	limit 50;

select apn, count(*)
	from permit
	where permittype = 'RESIDENTIAL SHORT TERM RENTAL'
	group by apn
	having count(*) >1;

select * from permit where apn = '07113000200' and permittype = 'RESIDENTIAL SHORT TERM RENTAL'

select apn, count(*) from property group by apn having count(*) >1;

with prop as 
		(select distinct apn, propzip from property),
	rent as
		(select apn, max(dateissued) as max_dateissued
			from permit
			where permittype = 'RESIDENTIAL SHORT TERM RENTAL'
		 	group by apn)
select * from prop
	join rent on prop.apn = rent.apn
	order by propzip, max_dateissued;
	
select status, permitsubtype, count(*), min(dateissued), max(dateissued) 
from permit 
where permittype = 'RESIDENTIAL SHORT TERM RENTAL' 
group by status, permitsubtype;

with expired as 
	(select apn, "location", dateissued, status 
	 from permit 
	 where permittype = 'RESIDENTIAL SHORT TERM RENTAL' 
	 and status = 'EXPIRED'),
	 issued as
	 (select apn, "location", dateissued, status 
	 from permit 
	 where permittype = 'RESIDENTIAL SHORT TERM RENTAL' 
	 and status = 'ISSUED')
select * from expired
	join issued on issued.apn = expired.apn and issued.location = expired.location;
	
select * from permit where apn = '09310023500' and permittype = 'RESIDENTIAL SHORT TERM RENTAL'; 

with no_issue_date as (
	select distinct apn 
	from permit 
	where permittype = 'RESIDENTIAL SHORT TERM RENTAL' and dateissued is null)
select per.apn, max(per.dateissued) as max_date from permit per
	join no_issue_date nid on nid.apn = per.apn
	where permittype = 'RESIDENTIAL SHORT TERM RENTAL' 
	group by per.apn
	having max(per.dateissued) is null; -- > '1900-01-01';

select distinct apn 
from permit 
where permittype = 'RESIDENTIAL SHORT TERM RENTAL' and dateissued is null; -- 806

select status, count(*) from permit where permittype = 'RESIDENTIAL SHORT TERM RENTAL' and dateissued is null group by status;
select status, count(*) from permit where permittype = 'RESIDENTIAL SHORT TERM RENTAL' group by status;


/*
INSERT INTO property_updated
SELECT * from property WHERE assessdate >= '2021-01-01';
DELETE FROM property
WHERE assessdate >= '2021-01-01';
*/
