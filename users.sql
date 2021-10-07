Select
Count ( Distinct fullVisitorId) as Users
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits
