USE deliverydb;
DROP TABLE delivery_timing;
SET SQL_SAFE_UPDATES = 0;

SELECT column_name, data_type
FROM INFORMATION_SCHEMA.columns
WHERE table_schema = 'deliverydb'
AND table_name = 'delivery_timing';

-- Analyse On-Time Deliveries vs Late Deliveries
-- 1. create table
CREATE TEMPORARY TABLE delivery_timing (
    order_no TEXT NOT NULL,
    delivery_date DATE NOT NULL,
    otd_ld TEXT
);

-- 2. populate dates from deliveries table
INSERT INTO delivery_timing(order_no, delivery_date, otd_ld)
SELECT order_no, delivery_date, otd_ld
FROM deliveries;


-- 3. check if delivery dates include weekends
SELECT delivery_date, dayname(delivery_date)
FROM delivery_timing;
--  as we can see, deliveries are being made during the weekends as well, meaning that we need to count calendar days. 

-- On-Time Delivery (OTD) and Late Delivery (LD) rates in %
-- 1. calculate number of orders delayed and on-time.
SELECT 
    YEAR(delivery_date) as yr,
    SUM(CASE WHEN otd_ld='On-Time Delivery' THEN 1 ELSE 0 END) AS orders_on_time,
    SUM(CASE WHEN otd_ld='Late Delivery' THEN 1 ELSE 0 END) AS orders_late
FROM
    delivery_timing
GROUP BY yr;
-- Because some orders have been divided into several shipments, for this particular KPI, we're going to treat each row as a distinct order

-- 2. calculate OTD and LD %:
SELECT YEAR(delivery_date) as yr,
    ROUND(((SUM(CASE WHEN otd_ld='On-Time Delivery' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 2) AS OTD_perc,
    ROUND(((SUM(CASE WHEN otd_ld='Late Delivery' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 2) AS LD_perc
FROM
    delivery_timing
    GROUP BY yr;
-- Since a high-level of delivery performance is 95 percent or higher on-time delivery, we can see that we have a serious delivery issues