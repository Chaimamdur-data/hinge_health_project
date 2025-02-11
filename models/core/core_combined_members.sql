{{ config(
    materialized='view',
    database='workspace'
) }}
WITH softball AS (
    SELECT
        id,
        first_name,
        last_name,
        dob,
        company_id,
        last_active,
        score,
        joined_year,
        state,
        'softball' AS source
    FROM {{ ref('stg_us_softball_league') }}
),

golf AS (
    SELECT
        id,
        first_name,
        last_name,
        dob,
        company_id,
        last_active,
        score,
        joined_year,
        state,
        'golf' AS source
    FROM {{ ref('stg_unity_golf_club') }}
),

combined AS (
    SELECT * FROM softball
    UNION ALL
    SELECT * FROM golf
)

SELECT
    c.id,
    c.first_name,
    c.last_name,
    c.dob,
    co.company_name,
    c.last_active,
    c.score,
    c.joined_year,
    c.state,
    c.source
FROM combined c
LEFT JOIN {{ ref('stg_companies') }} co
ON c.company_id = co.company_id;
