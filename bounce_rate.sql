SELECT
Page,
( ( bounces / sessions ) * 100 ) AS Bounce_Rate,
Sessions
FROM (
SELECT
hits.page.pagePath AS Page,
Count ( Distinct
CASE
WHEN totals.visits=1 THEN
CONCAT( fullvisitorid,"-",CAST(visitNumber AS string),"-",CAST(visitStartTime AS string))
End)
as Sessions,
SUM ( totals.bounces ) AS Bounces
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits
GROUP BY
Page )
ORDER BY
Sessions DESC
