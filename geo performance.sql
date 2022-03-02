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
    city TEXT,
    promised_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    days_variance INTEGER,
    country TEXT,
    yr TEXT,
    mnth TEXT
);
	
-- 2. populate dates from deliveries table
INSERT INTO geo_delivery(order_no, vendor_name, city, promised_date, delivery_date, days_variance, country)
SELECT order_no, vendor_name, city, promised_date, delivery_date, days_variance, country
FROM deliveries;

SELECT * FROM geo_delivery;

-- 3. populate yr and mnth
UPDATE geo_delivery 
SET yr = SUBSTR(promised_date, 1, 4);
UPDATE geo_delivery 
SET mnth = SUBSTR(promised_date, 6, 2);




-- average day variance in Germany, per city
SELECT city, ROUND(AVG(days_variance)) AS avg_variance
FROM geo_delivery
WHERE country='Germany'
GROUP BY city;

-- average day variance in other countries
SELECT country, ROUND(AVG(days_variance)) AS avg_variance
FROM geo_delivery
WHERE country!='Germany'
GROUP BY country;

-- average day variance in Germany, per yr
SELECT yr, ROUND(AVG(days_variance)) AS avg_variance
FROM geo_delivery
WHERE country='Germany'
GROUP BY yr;