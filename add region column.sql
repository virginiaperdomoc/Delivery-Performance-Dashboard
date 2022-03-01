USE deliverydb;
SET SQL_SAFE_UPDATES = 0;


SELECT DISTINCT country 
FROM deliveries, cities
WHERE deliveries.vendor_city=cities.city;

ALTER TABLE cities
ADD COLUMN region TEXT AFTER country;

UPDATE cities
SET region = CASE 
                WHEN country='Germany' THEN 'Germany'
                WHEN country='Japan' THEN 'Asia'
                WHEN country IN ('Canada', 'United States') THEN 'North America'
                WHEN country IN ('Austria', 'Belgium','Czechia','Poland','Portugal', 'Switzerland') THEN 'Europe'
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

SELECT vendor_no, vendor_name, vendor_city, country, region, order_no, delivery_no, order_date, 
posting_date promised_date, delivery_date, days_variance, otd_ld
FROM deliveries, cities
WHERE deliveries.vendor_city=cities.city
AND delivery_date < '2022-02-20'
AND order_date < delivery_date
AND order_date < promised_date;