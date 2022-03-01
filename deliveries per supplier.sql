-- Deliveries per vendor
-- 1. Create CTE
WITH vendors_deliveries AS (
SELECT DISTINCT deliveries.order_no AS order_no, vendors.search_name AS vendors, deliveries.delivery_date
FROM vendors
JOIN deliveries 
ON vendors.search_name=deliveries.vendor_name AND deliveries.promised_date NOT LIKE '2033%')


-- calculate number of orders delivered per vendor, per year, per mnth
SELECT vendors, SUBSTR(delivery_date, 1, 4) AS yr, SUBSTR(delivery_date, 6, 2) AS mnth, COUNT(order_no) AS orders_delivered
FROM vendors_deliveries
GROUP BY vendors, yr, mnth
ORDER BY yr, mnth;

-- calculate number of orders delivered per vendor
SELECT vendors, COUNT(order_no) AS orders_delivered
FROM vendors_deliveries
GROUP BY vendors;

-- calculate number of orders delivered per vendor, per year
SELECT vendors, SUBSTR(delivery_date, 1, 4) AS yr, COUNT(order_no) AS orders_delivered
FROM vendors_deliveries
GROUP BY vendors, yr
ORDER BY yr;