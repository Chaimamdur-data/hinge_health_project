{{ config(
    materialized='incremental',
    unique_key='fact_member_id'
) }}

WITH member_data AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['m.id']) }} AS fact_member_id,
        c.company_sk,
        l.location_sk,
        m.member_sk,
        m.last_active AS activity_date,
        m.score,
        (YEAR(CURRENT_DATE) - m.joined_league) AS membership_tenure
    FROM {{ ref('core_combined_members') }} m
    LEFT JOIN {{ ref('dim_company') }} c ON m.company_id = c.company_sk
    LEFT JOIN {{ ref('dim_location') }} l ON m.state = l.state
)
SELECT * FROM member_data

