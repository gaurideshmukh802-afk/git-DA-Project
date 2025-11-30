SELECT 
    u.age,
    g.genre,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN users u ON r.userId = u.userId
JOIN movies m ON r.movieId = m.movieId
CROSS JOIN JSON_TABLE(
    REPLACE(CONCAT('["', REPLACE(m.genres, '|', '","'), '"]'), '""', '"'),
    "$[*]" COLUMNS (genre VARCHAR(50) PATH "$")
) g
GROUP BY u.age, g.genre
HAVING COUNT(*) > 20
ORDER BY u.age, avg_rating DESC;

SELECT 
    m.title,
    AVG(r.rating) AS avg_rating,
    COUNT(*) AS total_reviews
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY r.movieId
HAVING COUNT(*) > 50
ORDER BY avg_rating DESC
LIMIT 10;

SELECT userId, COUNT(*) AS total_ratings
FROM ratings
GROUP BY userId
ORDER BY total_ratings DESC
LIMIT 10;

SELECT 
    u.gender,
    u.age,
    g.genre,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN users u ON r.userId = u.userId
JOIN movies m ON r.movieId = m.movieId
CROSS JOIN JSON_TABLE(
    REPLACE(CONCAT('["', REPLACE(m.genres, '|', '","'), '"]'), '""', '"'),
    "$[*]" COLUMNS (genre VARCHAR(50) PATH "$")
) g
GROUP BY u.gender, u.age, g.genre
HAVING COUNT(*) > 20
ORDER BY u.gender, u.age, avg_rating DESC;

SELECT COUNT(*) AS users_above_500
FROM (
    SELECT userId, COUNT(*) AS total
    FROM ratings
    GROUP BY userId
    HAVING COUNT(*) > 500
) AS t;

SELECT 
    m.movieId,
    m.title,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
GROUP BY m.movieId
ORDER BY avg_rating DESC;

SELECT genres, COUNT(*) AS count_movies
FROM movies
GROUP BY genres
ORDER BY count_movies DESC
LIMIT 10;

SELECT 
    m.title,
    AVG(r.rating) AS avg_rating
FROM ratings r
JOIN movies m ON r.movieId = m.movieId
WHERE r.rating > 4.5
  AND FROM_UNIXTIME(r.timestamp) >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY r.movieId
ORDER BY avg_rating DESC;

