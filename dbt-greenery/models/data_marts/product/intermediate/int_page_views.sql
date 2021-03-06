{{
  config(
    materialized='table'
  )
}}
with int_page_views as (
    select 
    {{ dbt_date.month_name('created_at', short=false) }} as month_name,
    event_id,
    user_id,
    session_id,
    count(session_id) over (partition by to_char(created_at,'Month')) as views_per_month
    from {{ref('stg_events')}}
    where event_type = 'page_view'  
)

select 
*
from int_page_views