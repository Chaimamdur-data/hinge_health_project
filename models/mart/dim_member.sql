{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['id']) }} AS member_sk,
    id AS natural_member_id,
    first_name,
    last_name,
    dob,
    state
FROM {{ ref('core_combined_members') }}


