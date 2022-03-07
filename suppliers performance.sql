-- Vendors' performance
-- 1. Create CTE
-- WITH vendors_perf AS (
-- SELECT vendors.search_name AS vendors, deliveries.order_no AS order_no, deliveries.promised_date AS promised_date, deliveries.delivery_date AS delivery_date
-- FROM vendors
-- JOIN deliveries 
-- ON vendors.search_name=deliveries.vendor_name)

-- calculate average variance per provider, per year, per mnth
SELECT vendor_name, YEAR(delivery_date) AS yr, MONTH(delivery_date) AS mnth, ROUND(AVG(days_variance)) AS avg_variance
FROM deliveries
GROUP BY vendor_name, yr, mnth
ORDER BY yr, mnth;

-- calculate average variance per provider, per year
SELECT vendor_name, YEAR(delivery_date) AS yr, ROUND(AVG(days_variance)) AS avg_variance
FROM deliveries
GROUP BY vendor_name, yr
ORDER BY yr;

-- calculate average variance per provider
SELECT vendor_name, ROUND(AVG(days_variance)) AS avg_variance
FROM deliveries
GROUP BY vendor_name;
