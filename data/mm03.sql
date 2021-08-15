/**************TAYLOR'S*RENTALS*QUERY*********************************/
/* Another factor that can drive up housing costs is houses being used as short-term rental properties. 
(See this article published in Harvard Law & Policy Review.) 
Which areas of town has seen a large number of short-term rental permits? 
Have these areas also seen an increase in home prices?
*/
​
-- list of apns that have short term rental permits
SELECT apn
FROM permit
WHERE permittype = 'RESIDENTIAL SHORT TERM RENTAL';
​
--create function for median
CREATE OR REPLACE FUNCTION _final_median(numeric[])
   RETURNS numeric AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;
CREATE AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);
​
--rental properties
WITH rentals_2017 AS (
	SELECT property.propzip, 
		COUNT(*) as units_2017, 
		ROUND(MEDIAN(property.totlappr), 2) as median_appraisal_2017
	FROM property
		WHERE apn IN (
			SELECT apn
			FROM permit
			WHERE permittype = 'RESIDENTIAL SHORT TERM RENTAL')
	GROUP BY property.propzip
	ORDER BY 2 DESC
),
rentals_2020 AS (
	SELECT property_updated.propzip, 
		COUNT(*) as units_2020, 
		ROUND(MEDIAN(property_updated.totlappr), 2) as median_appraisal_2020
	FROM property_updated
		WHERE apn IN (
			SELECT apn
			FROM permit
			WHERE permittype = 'RESIDENTIAL SHORT TERM RENTAL')
	GROUP BY property_updated.propzip
	ORDER BY 2 DESC
)
SELECT rentals_2017.propzip, 
	units_2017, 
	units_2020, 
	units_2017-units_2020 AS units_lost,
	median_appraisal_2017,
	median_appraisal_2020, 
	median_appraisal_2020-median_appraisal_2017 AS appraisal_change
FROM rentals_2017
JOIN rentals_2020
	ON rentals_2017.propzip = rentals_2020.propzip
ORDER BY units_lost DESC;
​
Collapse



:ty:
1

