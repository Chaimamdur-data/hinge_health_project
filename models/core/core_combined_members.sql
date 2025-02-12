{{ config(
    materialized='table'',
    database='workspace'
) }}
{{ config(
    materialized='incremental',
    unique_key='id'
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
    
    {% if is_incremental() %}
    WHERE last_active > (SELECT MAX(last_active) FROM {{ this }})
    {% endif %}
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
    
    {% if is_incremental() %}
    WHERE last_active > (SELECT MAX(last_active) FROM {{ this }})
    {% endif %}
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

