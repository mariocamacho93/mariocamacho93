SELECT
    Landing_Page,
    second_page_path,
    third_page_path,
    fourth_page_path, 
    count (distinct SessionIdentity) as Sessions
  FROM (
    SELECT
      CASE
        WHEN totals.visits=1 THEN CONCAT( fullvisitorid,"-",CAST(visitNumber AS string),"-",CAST(visitStartTime AS string))
    END
      AS SessionIdentity,
  
      CASE
        WHEN hits.isEntrance=TRUE THEN hits.page.pagePath
    END
      AS Landing_Page,
      CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,1) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS second_page_path,
        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,2) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS third_page_path,
        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,3) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS fourth_page_path,
        CASE
          WHEN hits.isEntrance = TRUE THEN LEAD( hits.page.pagePath,4) OVER (PARTITION BY fullVisitorId, visitNumber ORDER BY hits.type)
        ELSE
        NULL
      END
        AS fifth_page_path,
   
   from
`bigquery-public-data.google_analytics_sample.ga_sessions_20170*` , UNNEST(hits) AS hits
   ORDER BY
      SessionIdentity,
      Landing_Page)
  WHERE
    SessionIdentity IS NOT NULL
    AND landing_page IS NOT NULL
  GROUP BY
    landing_page,
    second_page_path,
    third_page_path,
    fourth_page_path
    
  ORDER BY
    Sessions Desc
