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
    state TEXT,
    delivery_date DATE NOT NULL,
    days_variance INTEGER,
    country TEXT,
    yr TEXT,
    mnth TEXT
);
	
-- 2. populate table
INSERT INTO geo_delivery(order_no, vendor_name, state, delivery_date, days_variance, country)
SELECT order_no, vendor_name, state, delivery_date, days_variance, country
FROM deliveries;

SELECT * FROM geo_delivery;

-- 3. populate yr and mnth
UPDATE geo_delivery 
SET yr = YEAR(delivery_date);
UPDATE geo_delivery 
SET mnth = MONTH(delivery_date);

-- average day variance in Germany, per state
SELECT state, ROUND(AVG(days_variance)) AS avg_variance
FROM geo_delivery
GROUP BY state;

-- average day variance per yr
SELECT state, yr, ROUND(AVG(days_variance)) AS avg_variance
FROM geo_delivery
GROUP BY state, yr;