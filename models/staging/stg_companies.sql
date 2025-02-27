{{ config(
    materialized='view'
) }}
WITH source AS (
    SELECT
        id,
        first_name,
        last_name,
        CAST(dob AS DATE) AS dob,
        company_id,
        CAST(last_active AS DATE) AS last_active,
        score,
        CAST(member_since AS INT) AS joined_year,
        UPPER(state) AS state
    FROM {{ ref('raw_unity_golf_club') }}
)
SELECT * FROM source
