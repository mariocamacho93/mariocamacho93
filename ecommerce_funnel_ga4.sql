WITH ecommerceProducts as (
SELECT 
item_name,
count(case when event_name = 'view_item' then concat(event_timestamp, cast(user_pseudo_id as string)) else null end) as item_views,
count(case when event_name = 'add_to_cart' then concat(event_timestamp, cast(user_pseudo_id as string)) else null end) as addtocart,
count(case when event_name = 'purchase' then ecommerce.transaction_id else null end) as ec_purchase,
sum(item_revenue) as ec_revenue

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_202101*`,
unnest(items) as items
group by
item_name 
)
select item_name, item_views, addtocart, ec_purchase, ec_revenue
from ecommerceProducts 
where item_views > 0 OR ec_revenue > 0
order by item_views
