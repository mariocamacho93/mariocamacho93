WITH 
firstVisit as (
  select Distinct user_pseudo_id as users, 
  event_date 
  from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where event_name = 'first_visit'),
     
userEngagement as (select 
       parse_date('%Y%m%d', firstVisit.event_date) as first_visit_date,
       date_diff(parse_date('%Y%m%d', u.event_date) , parse_date('%Y%m%d', firstVisit.event_date), isoweek) as week_since_user_engagement,
       count(Distinct user_pseudo_id) as users
 FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` u 
 left join firstVisit
       on
       firstVisit.users = u.user_pseudo_id
 where event_name = 'user_engagement'
 group by week_since_user_engagement,
          first_visit_date)
select first_visit_date,
  SUM(CASE WHEN week_since_user_engagement = 0 THEN users ELSE 0 END) as week_0,
  SUM(CASE WHEN week_since_user_engagement = 1 THEN users ELSE 0 END) as week_1,
  SUM(CASE WHEN week_since_user_engagement = 2 THEN users ELSE 0 END) as week_2,
  SUM(CASE WHEN week_since_user_engagement = 3 THEN users ELSE 0 END) as week_3,
  SUM(CASE WHEN week_since_user_engagement = 4 THEN users ELSE 0 END) as week_4,
  SUM(CASE WHEN week_since_user_engagement = 5 THEN users ELSE 0 END) as week_5,
  SUM(CASE WHEN week_since_user_engagement = 6 THEN users ELSE 0 END) as week_6
from userEngagement
group by first_visit_date
having week_0 > 0 LIMIT 100; 
