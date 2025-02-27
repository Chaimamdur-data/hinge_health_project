{{ config(
    database='workspace'
    materialized='incremental',
    unique_key='id'
) }}


)

SELECT * FROM {{ ref('core_combined_members') }}
WHERE joined_year < YEAR(dob)  
    OR last_active < dob
    
{% if is_incremental() %}
AND last_active > (SELECT MAX(last_active) FROM {{ this }})
{% endif %};

