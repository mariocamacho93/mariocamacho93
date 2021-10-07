Select
hits.page.pagePath AS Page,
SUM(
CASE
WHEN hits.isExit = TRUE and hits.type="PAGE" AND totals.visits=1 THEN 1
ELSE 0
END
) AS Exits,
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits
group by Page
