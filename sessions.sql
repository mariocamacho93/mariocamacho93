Select
Count ( Distinct
CASE
WHEN totals.visits=1 THEN
CONCAT( fullvisitorid,"-",CAST(visitNumber AS string),"-",CAST(visitStartTime AS string))
End)
as Sessions
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits
