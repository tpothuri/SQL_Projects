# 📊 Netflix Movies and TV Shows Data Analysis using SQL 

## Overview
A beginner-friendly SQL project that explores and analyzes the Netflix catalog using PostgreSQL queries. This repository covers different business perspectives such as content strategy, regional insights, trend analysis, talent insights, and content quality classification.

## Objectives
1. Analyze the distribution of content across movies and TV shows to understand platform composition.
2. Identify the most commonly assigned ratings for both content types to uncover audience targeting strategies.
3. Examine trends in content based on release year, country of origin, and duration to gain insights into regional and temporal patterns.
4. Classify and filter content using specific keywords and criteria to explore thematic and qualitative aspects of the catalog.
---
## 📁 Dataset Source
The data for this project is sourced from the Kaggle dataset:
Dataset Link: Movies Dataset(https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
```sql
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
```

## Business Problems and Solutions

## 🎯 Content Strategy & Catalog Optimization

### 1. Count of Movies vs. TV Shows

```sql
SELECT
    type,
    COUNT(*) AS total
FROM netflix
GROUP BY type;
```

**Description**: Returns the number of rows for each content type (Movie vs. TV Show).

### 2. Count of Content per Genre

```sql
SELECT
    listed_in,
    COUNT(*) AS total
FROM netflix
GROUP BY listed_in
ORDER BY total DESC;
```

**Description**: Shows how many items fall into each genre category as listed in the dataset.

### 3. Longest Movie

```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY duration DESC
LIMIT 1;
```

**Description**: Finds the single longest movie by ordering on the duration column (assuming a numeric format like "120 min").

### 4. TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND (
    duration LIKE '6% Season%'
    OR duration LIKE '7% Season%'
    OR duration LIKE '8% Season%'
  );
```

**Description**: Lists all TV shows whose duration indicates more than 5 seasons.

### 5. Most Common Ratings per Content Type

```sql
SELECT
    type,
    rating,
    COUNT(*) AS total
FROM netflix
GROUP BY type, rating
ORDER BY type, total DESC;
```

**Description**: Counts how many times each rating appears for movies vs. TV shows.

---

## 🌍 Regional & Market Insights

### 6. Top 5 Countries with the Most Content

```sql
SELECT
    country,
    COUNT(*) AS total
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total DESC
LIMIT 5;
```

**Description**: Identifies the five countries contributing the largest number of titles.

### 7. Indian Content by Year (Top 5 Years)

```sql
SELECT
    release_year,
    COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;
```

**Description**: Shows the years with the most releases from India.

### 8. Content by Genre for India

```sql
SELECT
    listed_in,
    COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY listed_in
ORDER BY total DESC;
```

**Description**: Counts how many Indian titles fall into each genre.

### 9. Movies or Shows by Director "Rajiv Chilaka"

```sql
SELECT *
FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';
```

**Description**: Retrieves all rows where the director column contains "Rajiv Chilaka".

### 10. Show Count by Country

```sql
SELECT
    country,
    COUNT(*) AS total
FROM netflix
GROUP BY country
ORDER BY total DESC;
```

**Description**: Global ranking of countries by number of titles.

---

## 📈 Temporal Analysis & Trends

### 11. Content Added in the Last 5 Years

```sql
SELECT *
FROM netflix
WHERE date_added >= '2019-01-01';
```

**Description**: Lists all titles added to Netflix in the last 5 years.

### 12. Movies Released in 2020

```sql
SELECT *
FROM netflix
WHERE release_year = 2020
  AND type = 'Movie';
```

**Description**: Retrieves all movies released in 2020.

### 13. Show Count by Release Year

```sql
SELECT
    release_year,
    COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY release_year DESC;
```

**Description**: Counts how many titles were released each year.

### 14. Monthly Additions (Trend by Month Name)

```sql
SELECT
    TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'Month') AS month,
    COUNT(*) AS total_added
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY month
ORDER BY total_added DESC;
```

**Description**: Shows which months see the most content additions.

### 15. Salman Khan Movies in Last 10 Years

```sql
SELECT *
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Description**: Finds titles featuring Salman Khan in the last decade.

---

## 🧑‍🤝‍🧑 Talent & Collaboration Insights

### 16. Top Actors in Indian Content

```sql
SELECT
    casts,
    COUNT(*) AS total
FROM netflix
WHERE country = 'India'
GROUP BY casts
ORDER BY total DESC
LIMIT 10;
```

**Description**: Lists the most common actor entries in Indian titles.

### 17. Frequent Director–Cast Collaborations

```sql
SELECT
    director,
    casts,
    COUNT(*) AS total
FROM netflix
WHERE director IS NOT NULL
  AND casts IS NOT NULL
GROUP BY director, casts
ORDER BY total DESC
LIMIT 10;
```

**Description**: Finds top 10 director-cast pairings.

### 18. Content Without a Director

```sql
SELECT *
FROM netflix
WHERE director IS NULL
   OR TRIM(director) = '';
```

**Description**: Lists all entries missing director information.

---

## 🧠 Content Classification & Quality

### 19. Movies That Are Documentaries

```sql
SELECT *
FROM netflix
WHERE listed_in LIKE '%Documentaries%';
```

**Description**: Returns all rows labeled as documentaries.

### 20. Classify Content Based on Keywords ("Kill" or "Violence")

```sql
SELECT
    CASE
        WHEN description LIKE '%kill%'
          OR description LIKE '%violence%'
        THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS content_count
FROM netflix
GROUP BY category;
```

**Description**: Classifies content as "Bad" or "Good" based on description keywords.


---
## Findings
**Content Distribution**:
The analysis reveals a well-balanced distribution between movies and TV shows on Netflix, reflecting the platform’s effort to cater to a broad audience with diverse viewing preferences.

**Content Ratings**:
The identification of the most frequent content ratings offers valuable insights into Netflix's content curation strategies and the intended demographic segments, indicating a strong focus on age-appropriate content.

** 🌍 Geographical Insights**:
Regional analysis highlights key content-producing countries, with India showing a notable contribution. Trends in release volumes by country and year shed light on global content acquisition and localization efforts.

** 🧠 Content Categorization**:
Keyword-based classification enables a thematic understanding of the available content, facilitating the assessment of narrative tone, subject matter, and genre diversity across the platform.

## Conclusion
This exploratory data analysis provides a comprehensive overview of Netflix’s content landscape. The insights derived can inform data-driven content strategy, regional market expansion, and audience engagement initiatives. By combining structural and thematic dimensions, the analysis supports more strategic content planning and platform optimization.
