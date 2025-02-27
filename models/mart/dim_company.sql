{{ config(materialized="table") }}


SELECT distinct
    HASH(
        COALESCE(CAST(c.company_id AS STRING), '_dbt_utils_surrogate_key_null_')
    ) AS company_sk,
    c.company_id AS company_id,
   case when s.company_id is null then 'company name not defined' else s.company_id AS company_name
FROM {{ ref('core_combined_members') }} c  
LEFT JOIN {{ ref('stg_companies') }} s
ON c.company_id = s.company_id

