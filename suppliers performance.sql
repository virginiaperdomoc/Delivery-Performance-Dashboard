-- Vendors' performance
-- 1. Create CTE
WITH vendors_perf AS (
SELECT vendors.search_name AS vendors, deliveries.order_no AS order_no, deliveries.promised_date AS promised_date, deliveries.delivery_date AS delivery_date
FROM vendors
JOIN deliveries 
ON vendors.search_name=deliveries.vendor_name
WHERE deliveries.promised_date NOT LIKE '2033%')

-- calculate average variance per provider, per year, per mnth
SELECT vendors, SUBSTR(promised_date, 1, 4) AS yr, SUBSTR(promised_date, 6, 2) AS mnth, ROUND(AVG(DATEDIFF(promised_date, delivery_date))) AS avg_variance
FROM vendors_perf
GROUP BY vendors, yr, mnth
ORDER BY yr, mnth;

-- calculate average variance per provider, per year
SELECT vendors, SUBSTR(promised_date, 1, 4) AS yr, ROUND(AVG(DATEDIFF(promised_date, delivery_date))) AS avg_variance
FROM vendors_perf
GROUP BY vendors, yr
ORDER BY yr;

-- calculate average variance per provider
SELECT providers, ROUND(AVG((DATEDIFF(promised_date, receipt_date)))) AS avg_variance
FROM providers_perf
GROUP BY providers;

-- calculate sum of variance per provider, per year
SELECT providers, SUM(DATEDIFF(promised_date, receipt_date)) AS sum_variance, SUBSTR(promised_date, 1, 4) AS yr
FROM providers_perf
GROUP BY providers, yr;