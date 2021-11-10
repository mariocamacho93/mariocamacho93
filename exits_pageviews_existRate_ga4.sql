SELECT hits.page.pagePath as page, 
sum(case  when hits.isExit = TRUE and hits.type="PAGE" AND totals.visits = 1 THEN 1 else 0
END) as exits,
sum(case when hits.type="PAGE" then 1 else 0 end) as pageviews,
sum(case  when hits.isExit = TRUE and hits.type="PAGE" AND totals.visits = 1 THEN 1 else 0
END) / sum(case when hits.type="PAGE" then 1 else 0 end) * 100 as exit_rate
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801` , 
unnest(hits) as hits
group by page 
