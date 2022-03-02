USE deliverydb;
SET SQL_SAFE_UPDATES = 0;


SELECT DISTINCT country 
FROM deliveries;

ALTER TABLE deliveries
ADD COLUMN region TEXT AFTER country;

UPDATE deliveries
SET region = CASE 
                WHEN country='Germany' THEN 'Germany'
                WHEN country IN ('China','Japan') THEN 'Asia'
                WHEN country IN ('Canada', 'United States') THEN 'North America'
                WHEN country IN ('Italy', 'Austria', 'Belgium','Czechia','Poland','Portugal', 'Spain', 'Switzerland', 'Hungary') THEN 'Europe'
              END;

ALTER TABLE deliveries
ADD COLUMN days_variance INTEGER AFTER delivery_date;

UPDATE deliveries 
SET days_variance = DATEDIFF(promised_date, delivery_date);

ALTER TABLE deliveries
ADD COLUMN otd_ld TEXT AFTER days_variance;

UPDATE deliveries 
SET otd_ld = CASE 
             WHEN days_variance >=0 THEN 'On-Time Delivery'
             WHEN days_variance <0 THEN 'Late Delivery'
             END;

SELECT * FROM deliveries;

SELECT vendor_no, vendor_name, city, country, region, order_no, delivery_no, order_date, 
posting_date, promised_date, delivery_date, days_variance, otd_ld
FROM deliveries;