
-- Analysis Of Movies Rating System :

/* ---------------------------------------------------------
   Q1: What are the top 5 highest-rated movies?
--------------------------------------------------------- */
SELECT m.title, ROUND(AVG(r.rating),2) AS avg_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC
LIMIT 5;

/*
Answer:
Top-rated movies have average ratings close to 4.7–5.0,
indicating strong audience satisfaction and quality content.
*/


/* ---------------------------------------------------------
   Q2: Which movies have received the most ratings?
--------------------------------------------------------- */
SELECT m.title, COUNT(r.rating_id) AS total_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY total_ratings DESC
LIMIT 5;

/*
Answer:
Movies with the highest number of ratings are the most popular
and widely watched among users.
*/


/* ---------------------------------------------------------
   Q3: What is the average rating for each genre?
--------------------------------------------------------- */
SELECT m.genre, ROUND(AVG(r.rating),2) AS avg_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;

/*
Answer:
Genres like Drama and Sci-Fi tend to have higher average ratings,
showing strong audience preference for these categories.
*/


/* ---------------------------------------------------------
   Q4: Who are the most active users?
--------------------------------------------------------- */
SELECT u.name, COUNT(r.rating_id) AS total_reviews
FROM users u
JOIN ratings r ON u.user_id = r.user_id
GROUP BY u.name
ORDER BY total_reviews DESC
LIMIT 5;

/*
Answer:
A small group of users contributes a large portion of ratings,
indicating highly engaged users.
*/


/* ---------------------------------------------------------
   Q5: What is the average rating per movie?
--------------------------------------------------------- */
SELECT m.title, ROUND(AVG(r.rating),2) AS avg_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title;

/*
Answer:
Most movies have ratings between 4.2–4.8,
showing generally positive audience feedback.
*/


/* ---------------------------------------------------------
   Q6: How do ratings change over time (monthly trend)?
--------------------------------------------------------- */
SELECT DATE_FORMAT(r.rating_date, '%Y-%m') AS month,
       ROUND(AVG(r.rating),2) AS avg_rating
FROM ratings r
GROUP BY month
ORDER BY month;

/*
Answer:
Ratings remain relatively stable over time with slight fluctuations,
indicating consistent user behavior.
*/


/* ---------------------------------------------------------
   Q7: Which users gave the highest ratings most frequently?
--------------------------------------------------------- */
SELECT u.name, COUNT(*) AS high_ratings
FROM users u
JOIN ratings r ON u.user_id = r.user_id
WHERE r.rating >= 4.5
GROUP BY u.name
ORDER BY high_ratings DESC
LIMIT 5;

/*
Answer:
Certain users tend to give higher ratings frequently,
indicating positive bias or preference for popular movies.
*/


/* ---------------------------------------------------------
   Q8: Which movies have low ratings?
--------------------------------------------------------- */
SELECT m.title, ROUND(AVG(r.rating),2) AS avg_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING avg_rating < 4.0;

/*
Answer:
Few movies fall below average ratings, indicating most movies
are well-received by users.
*/


/* ---------------------------------------------------------
   Q9: What is the rating distribution?
--------------------------------------------------------- */
SELECT 
    CASE 
        WHEN rating >= 4.5 THEN 'Excellent'
        WHEN rating >= 3.5 THEN 'Good'
        WHEN rating >= 2.5 THEN 'Average'
        ELSE 'Poor'
    END AS rating_category,
    COUNT(*) AS total
FROM ratings
GROUP BY rating_category;

/*
Answer:
Most ratings fall under 'Good' and 'Excellent',
showing overall positive sentiment.
*/


/* ---------------------------------------------------------
   Q10: Which genre is most popular (by number of ratings)?
--------------------------------------------------------- */
SELECT m.genre, COUNT(r.rating_id) AS total_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.genre
ORDER BY total_ratings DESC;

/*
Answer:
Popular genres receive more ratings, indicating higher audience engagement.
Action and Drama often dominate.
*/



/* ---------------------------------------------------------
   Q11: Which movies have the highest rating variance?
--------------------------------------------------------- */
SELECT m.title,
       ROUND(MAX(r.rating) - MIN(r.rating),2) AS rating_variance
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY rating_variance DESC
LIMIT 5;

/*
Answer:
Movies with high variance show mixed audience opinions,
indicating controversial or niche content.
*/


/* ---------------------------------------------------------
   Q12: What is the average rating by country?
--------------------------------------------------------- */
SELECT u.country, ROUND(AVG(r.rating),2) AS avg_rating
FROM users u
JOIN ratings r ON u.user_id = r.user_id
GROUP BY u.country
ORDER BY avg_rating DESC;

/*
Answer:
Some countries tend to give higher ratings,
showing cultural differences in movie preferences.
*/


/* ---------------------------------------------------------
   Q13: Which age group gives the highest ratings?
--------------------------------------------------------- */
SELECT 
    CASE 
        WHEN u.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN u.age BETWEEN 26 AND 35 THEN '26-35'
        ELSE '36+'
    END AS age_group,
    ROUND(AVG(r.rating),2) AS avg_rating
FROM users u
JOIN ratings r ON u.user_id = r.user_id
GROUP BY age_group
ORDER BY avg_rating DESC;

/*
Answer:
Younger users (18–25) often give slightly higher ratings,
indicating more positive engagement.
*/


/* ---------------------------------------------------------
   Q14: Which movies are most popular among Indian users?
--------------------------------------------------------- */
SELECT m.title, COUNT(*) AS total_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
JOIN users u ON u.user_id = r.user_id
WHERE u.country = 'India'
GROUP BY m.title
ORDER BY total_ratings DESC
LIMIT 5;

/*
Answer:
Indian users tend to engage more with regional and drama-based content.
*/


/* ---------------------------------------------------------
   Q15: Which users have not rated any movies?
--------------------------------------------------------- */
SELECT u.name
FROM users u
LEFT JOIN ratings r ON u.user_id = r.user_id
WHERE r.rating_id IS NULL;

/*
Answer:
These users are inactive and can be targeted for engagement strategies.
*/


/* ---------------------------------------------------------
   Q16: What is the average rating for movies released after 2015?
--------------------------------------------------------- */
SELECT ROUND(AVG(r.rating),2) AS avg_rating
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
WHERE m.release_year > 2015;

/*
Answer:
Recent movies generally receive slightly higher ratings,
possibly due to improved production quality.
*/


/* ---------------------------------------------------------
   Q17: Which movies have more than 10 ratings?
--------------------------------------------------------- */
SELECT m.title, COUNT(*) AS total_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING total_ratings > 10
ORDER BY total_ratings DESC;

/*
Answer:
Movies with more than 10 ratings are highly engaged titles
and represent popular content.
*/


/* ---------------------------------------------------------
   Q18: What is the average rating given per user?
--------------------------------------------------------- */
SELECT u.name, ROUND(AVG(r.rating),2) AS avg_rating
FROM users u
JOIN ratings r ON u.user_id = r.user_id
GROUP BY u.name
ORDER BY avg_rating DESC;

/*
Answer:
Some users consistently give higher ratings,
indicating personal bias or preferences.
*/


/* ---------------------------------------------------------
   Q19: Which movies received ratings in the last 30 days?
--------------------------------------------------------- */
SELECT DISTINCT m.title
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
WHERE r.rating_date >= CURDATE() - INTERVAL 30 DAY;

/*
Answer:
These movies are currently trending or recently watched.
*/


/* ---------------------------------------------------------
   Q20: Which genre has the most number of movies?
--------------------------------------------------------- */
SELECT genre, COUNT(*) AS total_movies
FROM movies
GROUP BY genre
ORDER BY total_movies DESC;

/*
Answer:
Genres with more movies indicate higher production focus,
such as Drama or Action.
*/