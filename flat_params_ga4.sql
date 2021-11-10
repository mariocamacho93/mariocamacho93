SELECT event_name,
ep.key as paremeter_key,
case
  when ep.value.string_value is not null then 'string'
  when ep.value.int_value is not null then 'int'
  when ep.value.double_value is not null then 'double'
  when ep.value.float_value is not null then 'float'
END 
AS paremeter_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
Unnest(event_params) as ep
where 
event_date between '20210101' and format_date('%Y%m%d', DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
group by 1, 2, 3
