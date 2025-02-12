{{ config(
    materialized='view',
    database='workspace'
) }}
WITH suspicious_records AS (
    SELECT * FROM {{ ref('core_combined_members') }}
    WHERE joined_year < YEAR(dob)  -- Invalid if joined before birth year
    OR last_active < dob           -- Invalid if last_active is before birth
)
SELECT * FROM {{ ref('core_combined_members') }}
WHERE id NOT IN (SELECT id FROM suspicious_records);
