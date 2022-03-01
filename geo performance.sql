-- Deliveries analysis by territory

USE deliverydb;
DROP TABLE geo_delivery;
SET SQL_SAFE_UPDATES = 0;

SELECT column_name, data_type
FROM INFORMATION_SCHEMA.columns
WHERE table_schema = 'deliverydb'
AND table_name = 'geo_delivery';

-- 1. create table
CREATE TEMPORARY TABLE geo_delivery (
    order_no TEXT,
    vendor_name TEXT,
    vendor_city TEXT,
    promised_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    days_variance INTEGER,
    yr TEXT,
    mnth TEXT
);
	
-- 2. populate dates from deliveries table
INSERT INTO geo_delivery(order_no, vendor_name, vendor_city, promised_date, delivery_date)
SELECT order_no, vendor_name, vendor_city, promised_date, delivery_date
FROM deliveries
WHERE promised_date NOT LIKE '2033%'
AND promised_date NOT LIKE '2099%';

SELECT * FROM geo_delivery;

-- 3. populate days_variance
UPDATE geo_delivery 
SET 
    days_variance = DATEDIFF(promised_date, delivery_date);

-- 4. populate yr and mnth
UPDATE geo_delivery 
SET yr = SUBSTR(promised_date, 1, 4);
UPDATE geo_delivery 
SET mnth = SUBSTR(promised_date, 6, 2);

-- 5. Join country colummn
SELECT order_no, vendor_name, vendor_city, days_variance, country
FROM geo_delivery, cities
WHERE geo_delivery.vendor_city=cities.city;


-- average day variance in Germany, per city
SELECT vendor_city, ROUND(AVG(days_variance),2) AS avg_variance
FROM geo_delivery, cities
WHERE geo_delivery.vendor_city=cities.city
AND country='Germany'
GROUP BY vendor_city;

-- average day variance in other countries
SELECT country, ROUND(AVG(days_variance),2) AS avg_variance
FROM geo_delivery, cities
WHERE geo_delivery.vendor_city=cities.city
AND country!='Germany'
GROUP BY country;

-- average day variance in Germany, per yr
SELECT yr, ROUND(AVG(days_variance),2) AS avg_variance
FROM geo_delivery, cities
WHERE geo_delivery.vendor_city=cities.city
AND country='Germany'
GROUP BY yr;