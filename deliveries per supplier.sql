-- Deliveries per vendor
-- 1. Create CTE
-- WITH vendors_deliveries AS (
-- SELECT DISTINCT deliveries.order_no AS order_no, vendors.search_name AS vendors, deliveries.delivery_date
-- FROM vendors
-- JOIN deliveries 
-- ON vendors.search_name=deliveries.vendor_name AND deliveries.promised_date NOT LIKE '2033%')

SELECT * FROM deliveries;
-- calculate number of distinct orders delivered per vendor, per year, per mnth
SELECT vendor_name, SUBSTR(delivery_date, 1, 4) AS yr, SUBSTR(delivery_date, 6, 2) AS mnth, COUNT(DISTINCT order_no) AS orders_delivered
FROM deliveries
WHERE delivery_date NOT LIKE '2033%'
AND delivery_date NOT LIKE '2099%'
GROUP BY vendor_name, yr, mnth
ORDER BY yr, mnth;

-- calculate number of orders delivered per vendor
SELECT vendor_name, COUNT(DISTINCT order_no) AS orders_delivered
FROM deliveries
WHERE delivery_date NOT LIKE '2033%'
AND delivery_date NOT LIKE '2099%'
GROUP BY vendor_name;

-- calculate number of distinct orders delivered per vendor, per year
SELECT vendor_name, SUBSTR(delivery_date, 1, 4) AS yr, COUNT(DISTINCT order_no) AS orders_delivered
FROM deliveries
WHERE delivery_date NOT LIKE '2033%'
AND delivery_date NOT LIKE '2099%'
GROUP BY vendor_name, yr
ORDER BY yr;