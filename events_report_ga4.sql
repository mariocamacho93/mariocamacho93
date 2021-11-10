WITH events as (
SELECT 
event_name,
(select value.string_value from unnest(event_params) where key = 'page_title') as page_title,
sum((select count(value.string_value) from unnest(event_params) where key = 'page_title')) as event_count,
count(distinct user_pseudo_id) as users,
sum((select count(value.string_value) from unnest(event_params)where key = 'page_title')) / count(distinct user_pseudo_id) as event_count_per_user

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_202101*`
where  event_name = 'page_view'
group by
event_name,
page_title
order by event_count desc 
)
select event_name, page_title, event_count, users, event_count_per_user
from events
order by event_count desc 
