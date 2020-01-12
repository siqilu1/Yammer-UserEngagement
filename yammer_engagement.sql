-- active users by week --

SELECT DATE_TRUNC('week', occurred_at) AS week_date, COUNT(event_type) AS engagement_count
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
GROUP BY week_date



-- active users in different countries --

SELECT DATE_TRUNC('week', occurred_at) AS date_week, location, count(user_id) as user_count
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
GROUP BY date_week, location
ORDER BY DATE_TRUNC('week', occurred_at) DESC



-- active users in different devices --

SELECT DATE_TRUNC('week', occurred_at) AS date_week,
    COUNT(CASE WHEN device IN ('macbook pro','lenovo thinkpad','macbook air','dell inspiron notebook', 'asus chromebook','dell inspiron desktop','acer aspire notebook','hp pavilion desktop','acer aspire desktop','mac mini') THEN 1 ELSE NULL END) AS computer_user,
    COUNT(CASE WHEN device IN ('iphone 5','samsung galaxy s4','nexus 5','iphone 5s','iphone 4s','nokia lumia 635', 'htc one','samsung galaxy note','amazon fire phone') THEN 1 ELSE NULL END) AS phone_user,
    COUNT(CASE WHEN device IN ('ipad air','nexus 7','ipad mini','nexus 10','kindle fire','windows surface', 'samsumg galaxy tablet') THEN 1 ELSE NULL END) AS tablet_user,
    COUNT(1) AS weekly_active_users
FROM tutorial.yammer_events events
WHERE event_type = 'engagement'
AND event_name = 'login'
GROUP BY date_week



-- new users VS old users

SELECT DATE_TRUNC('week', occurred_at) AS engagement_date_week, 
  COUNT(CASE WHEN TRUNC(DATE_PART('day', '2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 10 THEN 1 ELSE NULL END) AS "10+ weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 9 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 10 THEN 1 ELSE NULL END) AS "9 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 8 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 9 THEN 1 ELSE NULL END) AS "8 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 7 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 8 THEN 1 ELSE NULL END) AS "7 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 6 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 7 THEN 1 ELSE NULL END) AS "6 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 5 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 6 THEN 1 ELSE NULL END) AS "5 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 4 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 5 THEN 1 ELSE NULL END) AS "4 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 3 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 4 THEN 1 ELSE NULL END) AS "3 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 2 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 3 THEN 1 ELSE NULL END) AS "2 weeks",
  COUNT(CASE WHEN TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) >= 1 AND TRUNC(DATE_PART('day','2014-09-04'::TIMESTAMP - created_at::TIMESTAMP)/7) < 2 THEN 1 ELSE NULL END) AS "1 week",
  COUNT(1) AS total_engagement
FROM tutorial.yammer_users users
JOIN tutorial.yammer_events events
  ON users.user_id = events.user_id
WHERE events.event_type = 'engagement'
AND events.event_name = 'login'
AND occurred_at > '2014-4-28'
GROUP BY engagement_date_week
