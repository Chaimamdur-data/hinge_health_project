{{ config(
    materialized='incremental', 
    unique_key='id'  -- Ensures incremental updates are properly handled
) }}

WITH softball AS (
    SELECT
        s.id,
        s.first_name,
        s.last_name,
        s.dob,
        s.company_id,
        s.last_active,
        s.score,
        s.joined_year,
        sa.state_abbr AS state,  -- Standardized state abbreviation
        'softball' AS source
    FROM {{ ref('stg_us_softball_league') }} s
    LEFT JOIN {{ ref('state_abbreviations') }} sa
        ON upper(s.state) = upper(sa.state_name)  -- Match full state name to get abbreviation
    {{ incremental_filter('s.last_active') }}  -- Use macro here per discussion with Steve
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
        state,  -- Golf data already uses abbreviations
        'golf' AS source
    FROM {{ ref('stg_unity_golf_club') }}
    {{ incremental_filter('last_active') }}  -- Used macro here per discussion with Steve
),

combined AS (
    SELECT * FROM softball
    UNION ALL
    SELECT * FROM golf
)

SELECT
    c.source || '_' || c.id AS id,
    c.first_name,
    c.last_name,
    c.dob,
    c.company_id,
    c.last_active,
    c.score,
    c.joined_year,
    c.state,  -- Now always two-letter abbreviation
    c.source
FROM combined c
