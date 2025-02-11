{{ config(
    materialized='view',
    database='workspace'
) }}

SELECT * FROM analytics.us_softball_league;
