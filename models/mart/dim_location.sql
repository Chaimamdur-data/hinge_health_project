{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['state']) }} AS location_sk,
    state,
    CASE 
        WHEN state IN ('CA', 'OR', 'WA') THEN 'West'
        WHEN state IN ('NY', 'NJ', 'MA') THEN 'East'
        ELSE 'Other'
    END AS region
FROM {{ ref('core_combined_members') }}

