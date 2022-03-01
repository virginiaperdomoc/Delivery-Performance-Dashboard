USE deliverydb;
DROP TABLE delivery_timing;
SET SQL_SAFE_UPDATES = 0;

SELECT column_name, data_type
FROM INFORMATION_SCHEMA.columns
WHERE table_schema = 'deliverydb'
AND table_name = 'delivery_timing';

-- 1. create table
CREATE TEMPORARY TABLE delivery_timing (
    order_no TEXT NOT NULL,
    order_date DATE NOT NULL,
    promised_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    days_variance INT
);

-- 2. populate dates from deliveries table
INSERT INTO delivery_timing(order_no, order_date, promised_date, delivery_date)
SELECT order_no, order_date, promised_date, delivery_date
FROM deliveries
WHERE promised_date NOT LIKE '2033%'
AND promised_date NOT LIKE '2099%'
AND promised_date < '2022-02-23'
AND delivery_date < '2022-02-23'
AND order_date < '2022-02-23';


-- 3. check if delivery dates include weekends
SELECT promised_date, dayname(promised_date), delivery_date, dayname(delivery_date)
FROM delivery_timing;
--  as we can see, deliveries are being made during the weekends as well, meaning that we need to count calendar days, not business days. 

-- 4. populate days_variance
UPDATE delivery_timing 
SET days_variance = DATEDIFF(promised_date, delivery_date);

SELECT * FROM delivery_timing;

-- On-Time Delivery (OTD) and Late Delivery (LD) rates in %
-- 1. calculate number of orders delayed and on-time
SELECT 
    order_no,
    promised_date, delivery_date,
    SUM(CASE WHEN days_variance >= 0 THEN 1 ELSE 0 END) AS orders_on_time,
    SUM(CASE WHEN days_variance < 0 THEN 1 ELSE 0 END) AS orders_late
FROM
    delivery_timing
GROUP BY order_no ;
-- Because some orders have been divided into several shipments with different promised dates of delivery, for this particular KPI, we're going to treat each row as a distinct order
 
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN days_variance >= 0 THEN 1 ELSE 0 END) AS orders_on_time,
    SUM(CASE WHEN days_variance < 0 THEN 1 ELSE 0 END) AS orders_late
FROM
    delivery_timing;

-- 2. calculate OTD and LD %:
SELECT 
    ROUND(((SUM(CASE WHEN days_variance >= 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100), 2) AS OTD_perc,
    ROUND(((SUM(CASE WHEN days_variance < 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100), 2) AS LD_perc
FROM
    delivery_timing;
-- Since a high-level of delivery performance is 95 percent or higher on-time delivery, we can see that we have a serious delivery issues

SELECT order_no, promised_date, delivery_date, days_variance
FROM delivery_timing;