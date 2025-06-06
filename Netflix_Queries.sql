------- Netflix Project ------
--- Creating Netfilx Table ----
Create Table netflix
(
    show_id      VARCHAR(6),
    type         VARCHAR(10),
    title        VARCHAR(150),
    director     VARCHAR(208),
    casts        VARCHAR(1000),
    country      VARCHAR(150),
    date_added   VARCHAR(50),
    release_year INT,
    rating       VARCHAR(10),
    duration     VARCHAR(15),
    listed_in    VARCHAR(100),
    description  VARCHAR(250)
);

Select * from netflix;

Select Count(*) as total_content from netflix;

Select distinct(type) from netflix;

-- 1. Count of Movies vs TV Shows
SELECT type, COUNT(*) AS total
FROM netflix
GROUP BY type;

-- 2. Count of Content per Genre
SELECT listed_in, COUNT(*) AS total
FROM netflix
GROUP BY listed_in
ORDER BY total DESC;

-- 3. Longest Movie
SELECT * 
FROM netflix
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;

-- 4. TV Shows with More Than 5 Seasons
SELECT * 
FROM netflix
WHERE type = 'TV Show'
  AND duration LIKE '6% Season%' OR duration LIKE '7% Season%';

-- 5. Most Common Ratings per Content Type
SELECT type, rating, COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY type, total DESC;

-- 6. Top 5 Countries with the Most Content
SELECT country, COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
LIMIT 5;

-- 7. Indian Content by Year (Top 5 Years)
SELECT release_year, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;

-- 8. Content by Genre for India
SELECT listed_in, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY listed_in
ORDER BY total DESC;

-- 9. Movies or Shows by Director 'Rajiv Chilaka'
SELECT * 
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';

-- 10. Show Count by Country
SELECT country, COUNT(*) AS total
FROM netflix
GROUP BY country
ORDER BY total DESC;

-- 11. Content Added in the Last 5 Years
SELECT * 
FROM netflix
WHERE date_added >= '2019-01-01';

-- 12. Movies Released in 2020
SELECT * 
FROM netflix
WHERE release_year = 2020 AND type = 'Movie';

-- 13. Show Count by Release Year
SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY release_year DESC;

-- 14. Monthly Additions (Trend by Month Name)
SELECT 
    TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'Month') AS month,
    COUNT(*) AS total_added
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY month
ORDER BY total_added DESC;

-- 15. Prabhas Movies in the Last 10 Years
SELECT * 
FROM netflix
WHERE casts LIKE '%Prabhas%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 16. Top Actors in Indian Content
SELECT casts, COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY casts
ORDER BY total DESC
LIMIT 10;

-- 17. Frequent Director-Cast Collaborations (Simplified)
SELECT director, casts, COUNT(*) AS total
FROM netflix
WHERE director IS NOT NULL AND casts IS NOT NULL
GROUP BY director, casts
ORDER BY total DESC
LIMIT 10;

-- 18. Content Without a Director
SELECT *
FROM netflix
WHERE director IS NULL OR TRIM(director) = '';

-- 19. Movies That Are Documentaries
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries%';

-- 20. Classify Content Based on Keywords ('Kill', 'Violence')
SELECT 
    CASE 
        WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS content_count
FROM netflix
GROUP BY category;
