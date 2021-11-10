SELECT
  user_pseudo_id,
  geo.city,
  TIMESTAMP_MICROS(MIN(event_timestamp)) AS session_start_ts,
  traffic_source.name AS channel,
  traffic_source.medium AS medium,
  traffic_source.source AS source,
  (
  SELECT
    value.int_value
  FROM
    UNNEST(event_params)
  WHERE
    key = 'ga_session_number') AS session_number,
  COUNT((
    SELECT
      value.string_value
    FROM
      UNNEST(event_params)
    WHERE
      event_name = 'page_view'
      AND key = 'page_title')) AS user_pages_count,
  STRING_AGG(DISTINCT (
    SELECT
      value.string_value
    FROM
      UNNEST(event_params)
    WHERE
      event_name = 'page_view'
      AND key = 'page_title' )) AS distinct_pages,
  STRING_AGG((
    SELECT
      value.string_value
    FROM
      UNNEST(event_params)
    WHERE
      event_name = 'page_view'
      AND key = 'page_title'
    ORDER BY
      event_timestamp)) AS page_journey
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_2021*`
GROUP BY
  1,2,4,5,6,7
