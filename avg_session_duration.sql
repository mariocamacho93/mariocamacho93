Select Channel, SUM(Total_Session_Duration)/Count(Distinct Session) as Avg_Session_Duration
from(
Select
Channel, Session,
MAX(hitTIme)as Total_Session_Duration
from(
Select
channelGrouping as Channel,
case when totals.visits=1 then CONCAT( fullvisitorid ,"-",Cast(visitNumber as string),"-",cast(visitStartTime as string)) end as Session,
Case when hits.IsInteraction=TRUE then  hits.Time/1000 else 0 end as hitTime,
from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , UNNEST(hits) AS hits
           
 )
 group by channel, session)
group by Channel
