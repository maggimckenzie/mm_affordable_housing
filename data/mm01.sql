select * from property_updated limit 50;
select featuretype, count(*) from property_updated group by featuretype;
select featuretype, count(*) from property group by featuretype;
select count(*) from property;
select count(*) from property_updated;

select propzip, ludesc, count(*) 
	from property_updated 
	where ludesc in ('DUPLEX',
					'QUADPLEX',
					'RESIDENTIAL CONDO',
					'SINGLE FAMILY',
					'TRIPLEX',
					'ZERO LOT LINE')
	group by propzip, ludesc
	order by propzip;
select assessdate, count(*) from property_updated group by assessdate;

/* Land Use Desc List
(DUPLEX,
QUADPLEX,
RESIDENTIAL CONDO,
SINGLE FAMILY,
TRIPLEX,
ZERO LOT LINE)