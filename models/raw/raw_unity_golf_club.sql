{{ config(
    materialized='view',
    database='workspace'
) }}
SELECT * FROM analytics.unity_golf_club;
