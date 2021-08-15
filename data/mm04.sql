
select propzip, 
	apn, 
	landappr as land_2021, 
	imprappr as impr_2021, 
	totlappr as appr_2021 
	FROM property_updated 
	where ludesc = 'SINGLE FAMILY' 
		and featuretype not in ('COMMON', 'OPEN SPACE')
		and assessdate >= '2021-01-01' 
		and totlappr is not null;
select propzip, apn, landappr as land_2017, imprappr as impr_2017, totlappr as appr_2017 FROM property_updated where ludesc = 'SINGLE FAMILY' and featuretype <> 'COMMON' AND assessdate >= '2017-01-01' and totlappr is not null;


/************LOTS*OF*EXPLORATION*BELOW**********************/
select * from property_updated where ludesc = 'SINGLE FAMILY' and featuretype = 'OTHER';
select * from property_updated where ludesc = 'SINGLE FAMILY' and totlappr = 10519;
select assessdate, count(*) from property group by assessdate order by assessdate;
select apn, count(*) from property group by apn having count(*) > 1;
select apn, count(*) from property_updated group by apn having count(*) > 1;
select * from property where apn in ('071080Y00100CO','07105029400','071080Y00200CO','071080Y90000CO','07105029500');
select * from property_updated where ludesc in ('SINGLE FAMILY', 'DUPLEX','TRIPLEX','QUADPLEX','ZERO LOT LINE') limit 50;
select assessdate, count(*) from property group by assessdate;
select dateest from property where assessdate > '2017-01-01' and dateest > '2017-01-01' order by dateest;
select distinct ludesc from property_updated;
select * from "owner" where apn = '14807002300' order by ownerdate;
select * from property_updated where apn = '14807002300';
select * from property where apn = '14807002300';
select * from assessment where apn = '14807002300';
select * from property_updated where ludesc in ('SINGLE FAMILY', 'DUPLEX','TRIPLEX','QUADPLEX','ZERO LOT LINE') limit 50;
select * from property_updated where ludesc in ('DUPLEX','TRIPLEX','QUADPLEX') limit 50;
select * from property_updated where ludesc in ('ZERO LOT LINE') limit 50;
select * from property_updated where propaddr like '%806 OLYMPIC%';
SELECT distinct featuretype, ludesc from property_updated;
select distinct featuretype, ludesc, count(*) from property_updated where featuretype = 'CONDO' group by featuretype, ludesc;
select distinct featuretype from property_updated where ludesc is null;
select * 
	from property_updated
	where ludesc in ('SINGLE FAMILY', 'DUPLEX','TRIPLEX','QUADPLEX','ZERO LOT LINE')
		or (featuretype = 'CONDO' and ludesc = 'RESIDENTIAL CONDO')
select distinct featuretype from property_updated where ludesc = 'RESIDENTIAL CONDO'
select * from property_updated where featuretype = 'CONDO' and ludesc is null;
select * from property_updated where ludesc = 'RESIDENTIAL CONDO'
select distinct featuretype from property_updated where ludesc in ('DUPLEX','TRIPLEX','QUADPLEX','ZERO LOT LINE');
select * from property_updated where featuretype = 'ACREAGE TRACT' AND ludesc in ('DUPLEX','TRIPLEX','QUADPLEX','ZERO LOT LINE');
select * from property_updated where propaddr = '2510 EASTLAND AVE';
select propfraction, count(*) from property_updated where ludesc in ('RESIDENTIAL CONDO') and propfraction is not null group by propfraction;
select * from property_updated where propfraction = 'A' and ludesc = 'RESIDENTIAL CONDO'
SELECT * FROM property_updated where propaddr like '2616%AIRPARK%';