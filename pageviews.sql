Select
SUM(
Case when hits.type="PAGE" then 1 else 0 END
)
as Pageviews
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits;
