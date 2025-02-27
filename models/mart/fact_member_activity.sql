{{ config(
    unique_key='fact_member_id'
) }}



with
    member_data as (
        select
            md5(
                cast(
                    concat(
                        coalesce(cast(m.id as string), '_dbt_utils_surrogate_key_null_')
                    ) as string
                )
            ) as fact_member_id,
            c.company_sk,
            l.location_sk,
            m.id as member_sk,
            m.last_active as activity_date,
            m.score,
            (year(current_date) - m.joined_year) as membership_tenure
        from {{ ref('core_combined_members') }} m
        left join
            {{ ref('dim_company') }} c
            on m.company_id = c.company_id
            
        left join {{ ref('dim_location') }} l on m.state = l.state
    )
select *
from member_data

