{{ config(materialized='table') }}

SELECT 
    id AS member_sk,
    id AS member_id,
    first_name,
    last_name,
    dob,
    state
FROM {{ ref('core_combined_members') }}
