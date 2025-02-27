{{ config(
    materialized='view',
) }}
WITH source AS (
    SELECT
        id,
        SPLIT(name, ' ')[0] AS first_name,
        SPLIT(name, ' ')[1] AS last_name,
        CAST(date_of_birth AS DATE) AS dob,
        company_id,
        CAST(last_active AS DATE) AS last_active,
        score,
        CAST(joined_league AS INT) AS joined_year,
        UPPER(us_state) AS state
    FROM {{ ref('raw_us_softball_league') }}
)
SELECT * FROM source
