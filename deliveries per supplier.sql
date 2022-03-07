-- Deliveries per vendor
-- 1. Create CTE
-- WITH vendors_deliveries AS (
-- SELECT DISTINCT deliveries.order_no AS order_no, vendors.search_name AS vendors, deliveries.delivery_date
-- FROM vendors
-- JOIN deliveries 
-- ON vendors.search_name=deliveries.vendor_name AND deliveries.promised_date NOT LIKE '2033%')

SELECT * FROM deliveries;
-- calculate number of deliveries per vendor, per year, per mnth
SELECT vendor_name, YEAR(delivery_date) AS yr, MONTH(delivery_date) AS mnth, COUNT(*) AS deliveries
FROM deliveries
GROUP BY vendor_name, yr, mnth
ORDER BY yr, mnth;

-- calculate number of deliveries per vendor
SELECT vendor_name, COUNT(*) AS deliveries
FROM deliveries
GROUP BY vendor_name;

-- calculate number of distinct orders delivered per vendor, per year
SELECT vendor_name, YEAR(delivery_date) AS yr, COUNT(*) AS deliveries
FROM deliveries
GROUP BY vendor_name, yr
ORDER BY yr;