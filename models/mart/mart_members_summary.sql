{{ config(
    materialized='view',
    database='workspace'
) }}
SELECT
    state,
    COUNT(*) AS total_members,
    COUNT(CASE WHEN source = 'softball' THEN 1 END) AS softball_members,
    COUNT(CASE WHEN source = 'golf' THEN 1 END) AS golf_members,
    COUNT(CASE WHEN last_active >= CURRENT_DATE - INTERVAL 1 YEAR THEN 1 END) AS active_members_last_year
FROM {{ ref('mart_cleaned_members') }}
GROUP BY state;
