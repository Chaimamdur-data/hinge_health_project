{{ config(
    database='workspace'
    materialized='incremental',
    unique_key='id'
) }}

WITH suspicious_records AS (
    SELECT * FROM {{ ref('core_combined_members') }}
    WHERE joined_year < YEAR(dob)  
    OR last_active < dob
)

SELECT * FROM {{ ref('core_combined_members') }}
WHERE id NOT IN (SELECT id FROM suspicious_records)

{% if is_incremental() %}
AND last_active > (SELECT MAX(last_active) FROM {{ this }})
{% endif %};

