SELECT event_name,
ep.key as paremeter_key,
coalesce(value.string_value, cast(value.int_value as string),cast(value.float_value as string), cast(value.double_value as string)) as value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
Unnest(event_params) as ep
where 
event_date between '20210101' and format_date('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
