{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['state']) }} AS location_sk,
    state
FROM {{ ref('core_combined_members') }}
