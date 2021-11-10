SELECT country, city, count(visitId) as count_visits, rank() over (partition by country order by count(visitId) desc) as ranking
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
AND country IN ('Argentina', 'Colombia', 'Austria', 'United States', 'Uruguay', 'Peru', 'Mexico')
AND city != 'not available in demo dataset'
GROUP BY country, city;
