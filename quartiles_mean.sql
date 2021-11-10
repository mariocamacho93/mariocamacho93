SELECT
  SUM(visits) AS sessions,
  -- 5 will give the min, 25%, 50%, 75%, max with 20% error
  -- the more buckets, the better the approximation (error = 1/number of buckets)
  -- at the cost of more computation
  -- QUANTILES returns all of the buckets, use NTH to extract the bucket you want
  approx_quantiles(timeOnSite, 5)[safe_offset(2)] AS firstQuartile,
  approx_quantiles(timeOnSite, 5)[safe_offset(3)] AS mean,
  approx_quantiles(timeOnSite, 5)[safe_offset(3)] AS thirdQuartile
FROM (
  SELECT
    totals.visits as visits,
    -- Sessions with a single page view will have no time on site reported
    IF(totals.timeOnSite IS NULL, 0, totals.timeOnSite) as timeOnSite
  FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_201708*`
GROUP BY
  totals.visits,
  totals.timeOnSite )
