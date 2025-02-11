{{ config(
    materialized='view',
    database='workspace'
) }}
SELECT * FROM analytics.companies;
