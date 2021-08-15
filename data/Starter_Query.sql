-- Used to generate the file assessment.csv

WITH 
	sfh AS 
		(SELECT apn FROM property_updated WHERE ludesc = 'SINGLE FAMILY'),
	addr AS
		(SELECT apn, propaddr, propcity, propzip, council, taxdist
		FROM property_updated),
	appr AS 
			((SELECT apn, assessdate, landappr, imprappr, totlappr 
			FROM property_updated
			WHERE apn IN (SELECT * FROM sfh))
		UNION ALL
			(SELECT apn, assessdate, landappr, imprappr, totlappr
			FROM property
			WHERE apn IN (SELECT * FROM sfh))
		UNION ALL 
			(SELECT 
				apn,
				effectivedate AS assessdate,
				landapprvalue AS landappr,
				improveapprvalue AS imprapp,
				totalapprvalue AS totlappr
			FROM assessment 
			WHERE apn in (SELECT * FROM sfh)))
	SELECT *
	FROM appr
	NATURAL JOIN addr
ORDER BY apn ASC, assessdate DESC;