WITH source AS (
    SELECT
        id AS company_id,
        name AS company_name
    FROM {{ ref('raw_companies') }}
)
SELECT * FROM source;

