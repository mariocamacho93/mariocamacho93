WITH RANKING_DATA AS (
SELECT country, city, count(visitId) count_visits, rank() over (partition by country order by count(visitId) desc) as ranking
FROM `data-to-insights.ecommerce.all_sessions`
WHERE type = 'PAGE'
AND country IN ('Argentina', 'Colombia', 'Austria', 'United States', 'Uruguay', 'Peru', 'Mexico')
AND city != 'not available in demo dataset'
GROUP BY country, city)

SELECT *, SUM(count_visits) OVER(PARTITION BY Country order by count_visits ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) total_top_three 
FROM RANKING_DATA
WHERE ranking  in (1,2,3) -- Filtra el ranking 1, 2 y 3 para cada pais
order by country, ranking
