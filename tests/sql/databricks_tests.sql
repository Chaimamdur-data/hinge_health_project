
--️ Ensure company_name is populated
SELECT COUNT(*) AS missing_companies
FROM analytics.mart_cleaned_members
WHERE company_name IS NULL OR company_name = '';

-- Validate today's summary count within historical range
WITH last_week AS (
    SELECT total_members
    FROM analytics.mart_members_summary
    WHERE last_active >= CURRENT_DATE - INTERVAL 7 DAYS
)
SELECT 
    (SELECT total_members FROM analytics.mart_members_summary WHERE last_active = CURRENT_DATE) AS today_count,
    AVG(total_members) AS avg_count,
    AVG(total_members) * 0.8 AS lower_bound,
    AVG(total_members) * 1.2 AS upper_bound
FROM last_week;

-- ️ Ensure no duplicate member IDs
SELECT id, COUNT(*) 
FROM analytics.mart_cleaned_members
GROUP BY id
HAVING COUNT(*) > 1;

--Validate members have been active in the last 10 years
SELECT COUNT(*) AS outdated_members
FROM analytics.mart_cleaned_members
WHERE last_active < DATE_SUB(CURRENT_DATE, INTERVAL 10 YEAR);

