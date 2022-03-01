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
    promised_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
    days_variance INTEGER,
    yr TEXT,
    mnth TEXT
);
	
-- 2. populate dates from deliveries table
INSERT INTO delivery_timing(order_no, promised_date, delivery_date)
SELECT order_no, promised_date, delivery_date
FROM deliveries
WHERE promised_date NOT LIKE '2033%';

-- 3. populate days_variance
UPDATE delivery_timing 
SET 
    days_variance = DATEDIFF(promised_date, delivery_date);

-- 4. populate yr and mnth
UPDATE delivery_timing 
SET yr = SUBSTR(promised_date, 1, 4);
UPDATE delivery_timing 
SET mnth = SUBSTR(promised_date, 6, 2);


-- On-Time Delivery (OTD) and Late Delivery (LD) rates in %
-- 1. calculate number of orders delayed and on-time
SELECT 
    order_no,
    promised_date,
    SUM(CASE WHEN days_variance >= 0 THEN 1 ELSE 0 END) AS orders_on_time,
    SUM(CASE WHEN days_variance < 0 THEN 1 ELSE 0 END) AS orders_late
FROM
    delivery_timing
GROUP BY order_no , promised_date;
-- Because some orders have been divided into several shipments, we're going to treat each row as a distinct order

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
