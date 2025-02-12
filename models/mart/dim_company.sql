{{ config(materialized='table') }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['id']) }} AS company_sk,
    id AS natural_company_id,
    name AS company_name
FROM {{ ref('stg_companies') }}

