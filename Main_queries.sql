--Total number of mailmen
SELECT COUNT(DISTINCT s.user_username)
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST(state) AS s;


--Check all the mailmen
SELECT DISTINCT state.user_username,
FROM `database-dev-332416.database_prod.product`,
	UNNEST(state) AS state 
ORDER BY state.user_username;


--Check all dates recorder
SELECT DISTINCT(DATE(s.delivery_created_date)) AS giorno_lavorativo 
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST(state) AS s 
ORDER BY day;


--Total number of scans for each mailman
SELECT DISTINCT state.user_username as postini, COUNT(id) as scansioni 
FROM `database-dev-332416.database_prod.product`,
	UNNEST(state) AS state GROUP BY postini
ORDER BY scansioni DESC;


--Average number of scans per mailman
SELECT AVG(consegne) as Media_consegne, VARIANCE(consegne) as Varianza 
FROM(
	SELECT DISTINCT state.user_username as postini, COUNT(id) as consegne
	FROM `database-dev-332416.database_prod.product`, 
		UNNEST(state) AS state
	GROUP BY postini
	ORDER BY consegne DESC);


--Number of working days for each mailman
SELECT R.postini, COUNT(DISTINCT R.giorni) as giorni_lavorativi
FROM
	(SELECT DISTINCT state.user_username as postini, DATE(state.created_date) as giorni
	FROM `database-dev-332416.database_prod.product`, 
	 	UNNEST(state) AS state
	GROUP BY postini, giorni
	ORDER BY giorni DESC) as R 
GROUP BY R.postini
ORDER BY giorni DESC;


--Total amount of scans per day
SELECT DISTINCT(DATE(s.delivery_created_date)) AS giorno, COUNT(DISTINCT id) AS scansioni
FROM `database-dev-332416.database_prod.product`AS p, 
	UNNEST(state) AS s
GROUP BY giorno
ORDER BY scansioni DESC;


--Last recorder date
SELECT DISTINCT(DATE(s.delivery_created_date)) as ultima scansione 
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST(state) AS s
ORDER BY ultima scansione DESC LIMIT 1;


--Check for available and missing data in the latitude and longitude field, applied to one single postman
SELECT total, NotNull, IsNull, ROUND(IsNull * 100.0 / total,2) AS Null_percent, ROUND(NotNull * 100.0 / total,2) AS NotNull_percent
FROM (SELECT
	(SELECT SUM
		(CASE WHEN s.user_username = ‘Phi’
			AND s.created_date BETWEEN ‘2021-09-01T00:00:00.000’ AND ‘2021-10-10T00:00:00.000’
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p,
		UNNEST(state) AS s) 
	AS total,
	
	(SELECT SUM
		(CASE WHEN s.user_username = ‘Phi’
			AND s.created_date BETWEEN ‘2021-09-01T00:00:00.000’ AND ‘2021-10-10T00:00:00.000’
			AND s.delivery_latitude IS NOT NULL
			AND s.delivery_longitude IS NOT NULL
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
		UNNEST(state) AS s)
	AS NotNull,

	  (SELECT SUM
		(CASE WHEN s.user_username = ‘Phi’
			AND s.created_date BETWEEN ‘2021-09-01T00:00:00.000’ AND ‘2021-10-10T00:00:00.000’
			AND s.delivery_latitude IS NULL
			AND s.delivery_longitude IS NULL
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
		UNNEST(state) AS s)
	AS IsNull);


--Check for available and missing data in the latitude and longitude field
SELECT total, NotNull, IsNull, ROUND(IsNull * 100.0 / total,2) AS Null_percent, ROUND(NotNull * 100.0 / total,2) AS NotNull_percent
FROM (SELECT
	(SELECT COUNT(*) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
		UNNEST(state) AS s)
	AS total,
	  
	(SELECT SUM
		(CASE WHEN s.delivery_latitude IS NOT NULL
		AND s.delivery_longitude IS NOT NULL 
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
	 	UNNEST(state) AS s)
	AS NotNull,

	(SELECT SUM
		(CASE WHEN s.delivery_latitude IS NULL
		AND s.delivery_longitude IS NULL
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
	 	UNNEST(state) AS s)
	AS IsNull);


--Check for available and missing data in the created_date field
SELECT total, NotNull, IsNull, ROUND(IsNull * 100.0 / total,2) AS Null_percent, ROUND(NotNull * 100.0 / total,2) AS NotNull_percent
FROM (SELECT
	(SELECT COUNT(*) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, UNNEST(state) AS s)
		AS total,
	  
	(SELECT SUM
		(CASE WHEN p.created_date IS NOT NULL
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
	 	UNNEST(state) AS s)
		AS NotNull,
	  
	(SELECT SUM
		(CASE WHEN p.created_date IS NULL
			THEN 1 ELSE 0 END) AS deliveries
		FROM `database-dev-332416.database_prod.product`as p, 
		UNNEST(state) AS s)
		AS IsNull);


--Daily scans for every postman
SELECT DISTINCT s.user_username as postino,count(DISTINCT barcode) as scansioni, 
DATE(s.delivery_created_date) as giorno
FROM `database-dev-332416.database_prod.product`as p, 
	UNNEST(state) AS s
	WHERE s.name = ‘CONSEGNA’ and s.delivery_send_state = ‘SENT’
GROUP BY postino, giorno 
ORDER BY scansioni DESC;


--Daily scans for every postman after a specific date
SELECT DISTINCT s.user_username as postino,count(DISTINCT barcode) as scansioni, DATE(s.delivery_created_date) as giorno
FROM `database-dev-332416.database_prod.product`as p, 
	UNNEST(state) AS s
	WHERE s.name = ‘CONSEGNA’ and s.delivery_send_state = ‘SENT’ 
	AND date(s.created_date) >= ‘2021-09-01’
GROUP BY postino, giorno 
ORDER BY scansioni DESC;


--Daily scans for one specific postman
SELECT date(s.delivery_created_date) as giorno, count(DISTINCT id) as scansioni, 
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST(state) AS s
	WHERE s.user_username = ‘lambda’ 
GROUP BY giorno
ORDER BY giorno DESC;


--Weekly scans for every postman
SELECT EXTRACT(ISOWEEK FROM s.delivery_created_date) as settimana, count(DISTINCT id) as scansioni, s.user_username as postino
	FROM `database-dev-332416.database_prod.product`AS p, 
	UNNEST(state) AS s
WHERE s.name = ‘CONSEGNA’ AND s.delivery_send_state = ‘SENT’ 
GROUP BY settimana, postino
ORDER BY scansioni DESC;


--Monthly scans for every postman
SELECT EXTRACT(MONTH FROM s.delivery_created_date) as mese, count(DISTINCT id) as scansioni, s.user_username as user
FROM `database-dev-332416.database_prod.product`AS p, 
	UNNEST(state) AS s
	WHERE s.name = ‘CONSEGNA’ AND s.delivery_send_state = ‘SENT’ 
GROUP BY mese, user
ORDER BY scansioni DESC;


--Scans for one specific postman and one specific date
SELECT *
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST(state) AS s
	WHERE s.user_username = ‘NI’
	AND DATE(s.delivery_created_date) = ‘2021-10-21’
ORDER BY p.created_date DESC;


--Frequency of the mailman in the result I obtained with the previous query
SELECT COUNT(s.user_username) as frequenza_postino
FROM `database-dev-332416.database_prod.product`AS p,
	UNNEST (state) AS s
WHERE s.delivery_created_date = ‘2021-05-02T20:39:02.460000’ AND s.user_username = ‘NI’;


--Daily scan for every mailman using CONCAT
SELECT COUNT(concon) as scansioni, giorno, postino 
FROM (
	SELECT DISTINCT(CONCAT(giorno, barcode)) as concon, giorno, barcode, postino 
	FROM (
		SELECT barcode, date(s.created_date) as giorno, s.user_username as postino
		FROM `database-dev-332416.database_prod.product`as p, 
		UNNEST(state) AS s
		WHERE s.name = ‘CONSEGNA’
	) as test
) as res
group by giorno, postino order by scansioni DESC;


----Daily scan for every mailman using a subquery
SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) AS scansioni, res.user_username AS postino
FROM
(
	SELECT s.created_date, s.user_username
	FROM `database-dev-332416.database_prod.product`AS p, 
	UNNEST(state) AS s
	WHERE s.name = ‘CONSEGNA’
	GROUP by s.created_date, s.user_username
) AS res
GROUP BY giorno, postino 
ORDER BY scansioni DESC;


--Check for data inside and outside my desired range
SELECT totale, Sopra_600, Sotto_10 , Tra_10_e_600, ROUND(Sopra_600 * 100.0 / totale,2) AS Sopra_600_percent, ROUND(Sotto_10 * 100.0 / totale,2) AS Sotto_10_percent, ROUND(Tra_10_e_600 * 100.0 / totale,2) AS Tra_10_e_600_percent 
FROM (SELECT
	(
	SELECT COUNT(test.scansioni)
	FROM
		(SELECT giorno, scansioni, postino
		FROM
			(SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) AS scansioni, res.user_username AS postino 
			 FROM
				( SELECT s.created_date, s.user_username
				FROM `database-dev-332416.database_prod.product`AS p, 
					UNNEST(state) AS s
					WHERE s.name = ‘CONSEGNA’
				GROUP by s.created_date, s.user_username
				) AS res
			GROUP BY giorno, postino
			ORDER BY scansioni DESC)
		) as test
	)
	AS totale,

	(
	SELECT COUNT(test.scansioni)
	FROM
		(SELECT giorno, scansioni, postino
		FROM
			(SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) ASscansioni, res.user_username AS postino 
			 FROM
				(SELECT s.created_date, s.user_username
				FROM `database-dev-332416.database_prod.product`AS p, 
					UNNEST(state) AS s
					WHERE s.name = ‘CONSEGNA’
					GROUP by s.created_date, s.user_username
				) AS res
			GROUP BY giorno, postino
			ORDER BY scansioni DESC)
		WHERE scansioni >= 600) as test
	)
	AS Sopra_600,

	(
	SELECT COUNT(test.scansioni)
	FROM
		(SELECT giorno, scansioni, postino
		FROM
			(SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) AS scansioni, res.user_username AS postino 
			 FROM
				( SELECT s.created_date, s.user_username
					FROM `database-dev-332416.database_prod.product`AS p, 
					UNNEST(state) AS s
					WHERE s.name = ‘CONSEGNA’
					GROUP by s.created_date, s.user_username
				) AS res
			GROUP BY giorno, postino ORDER BY scansioni DESC) 
		WHERE scansioni <= 10) as test
	)
	AS Sotto_10,

	(
	SELECT COUNT(test.scansioni)
	FROM
		(SELECT giorno, scansioni, postino
		FROM
			(SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) AS scansioni, res.user_username AS postino 
			FROM
				( SELECT s.created_date, s.user_username
				FROM `database-dev-332416.database_prod.product`AS p, UNNEST(state) AS s
				WHERE s.name = ‘CONSEGNA’
				GROUP by s.created_date, s.user_username
				) AS res
			GROUP BY giorno, postino
			ORDER BY scansioni DESC)
		WHERE scansioni BETWEEN 10 AND 600) as test 
	)
	AS Tra_10_e_600);


--Daily scans for one specific postman
SELECT DATE(res.created_date) AS giorno , COUNT(res.created_date) AS scansioni, res.user_username AS postino
FROM
	(SELECT s.created_date, s.user_username
		FROM `database-dev-332416.database_prod.product`AS p, 
		UNNEST(state) AS s
		WHERE s.user_username = ‘lambda’
		GROUP by s.created_date, s.user_username
	) AS res
GROUP BY giorno, postino 
ORDER BY scansioni DESC;


--Mapping the data on BigQuery Geo Viz
SELECT ST_GEOGPOINT(s.delivery_longitude, s.delivery_latitude) AS position 
FROM `database-dev-332416.database_prod.product`AS p,
UNNEST(state) AS s
WHERE s.delivery_latitude IS NOT NULL 
	AND s.delivery_longitude IS NOT NULL 
	AND s.name = ‘CONSEGNA’;