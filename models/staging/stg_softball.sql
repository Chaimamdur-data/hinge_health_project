with raw as (
    select
        id,
        split_part(name, ' ', 1) as first_name,
        split_part(name, ' ', 2) as last_name,
        to_date(date_of_birth, 'MM/DD/YYYY') as dob,
        company_id,
        to_date(last_active, 'MM/DD/YYYY') as last_active,
        score,
        joined_league,
        case 
            when us_state = 'Illinois' then 'IL'
            when us_state = 'Wisconsin' then 'WI'
            when us_state = 'New Mexico' then 'NM'
            when us_state = 'New Jersey' then 'NJ'
            when us_state = 'Rhode Island' then 'RI'
            else us_state
        end as state
    from analytics.softball_raw
)

select * from raw;

