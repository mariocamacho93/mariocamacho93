select event_name,
       count(distinct user_pseudo_id) as users
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) > PARSE_DATE('%Y%m%d', @DS_START_DATE)
AND PARSE_DATE('%Y%m%d', _TABLE_SUFFIX) < PARSE_DATE('%Y%m%d', @DS_END_DATE)
AND traffic_source.source = @source
GROUP BY EVENT_NAME LIMIT 100; 
