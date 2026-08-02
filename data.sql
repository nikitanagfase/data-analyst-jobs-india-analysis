CREATE DATABASE data_analyst_jobs_india
CHARACTER SET utf8mb4;

USE data_analyst_jobs_india;

CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(255),
    company VARCHAR(255),
    min_exp DECIMAL(4,1),
    max_exp DECIMAL(4,1),
    base_salary DECIMAL(12,2),
    max_salary DECIMAL(12,2),
    location VARCHAR(255),
    joblisteddays_ago INT,
    postedin VARCHAR(100),
    rating DECIMAL(3,2),
    reviews_count INT,
    salary_data_provide_by VARCHAR(100),
    is_salary_disclosed BOOLEAN,
    primary_city VARCHAR(100),
    location_type VARCHAR(50),
    has_rating BOOLEAN
);

CREATE TABLE job_skills (
    job_id INT,
    skill VARCHAR(100),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);


USE data_analyst_jobs_india;
SELECT COUNT(*) FROM jobs;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/workn/Downloads/cleaned_data_analyst_jobs_india.csv'
INTO TABLE jobs
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(job_id, job_title, company, min_exp, max_exp, @base_salary, @max_salary, location,
 @joblisteddays_ago, postedin, @rating, @reviews_count, salary_data_provide_by,
 @is_salary_disclosed, primary_city, location_type, @has_rating)
SET
    base_salary = NULLIF(@base_salary, ''),
    max_salary = NULLIF(@max_salary, ''),
    joblisteddays_ago = NULLIF(@joblisteddays_ago, ''),
    rating = NULLIF(@rating, ''),
    reviews_count = NULLIF(@reviews_count, ''),
    is_salary_disclosed = CASE WHEN @is_salary_disclosed = 'True' THEN 1 ELSE 0 END,
    has_rating = CASE WHEN @has_rating = 'True' THEN 1 ELSE 0 END;
    
SELECT job_id, base_salary, max_salary FROM jobs
WHERE job_id IN (865, 1077, 1373, 1406);

SELECT * FROM job_skills;
SELECT * FROM jobs LIMIT 10;

SELECT job_title,company,base_salary
FROM jobs
WHERE base_salary IS NULL;

SELECT primary_city
FROM jobs
WHERE location = 'Hyderabad';



-- Which cities have the most Data Analyst job openings?
SELECT primary_city, COUNT(primary_city) AS job_count
FROM jobs
GROUP BY primary_city
ORDER BY job_count DESC
LIMIT 10;

-- Which skills appear most frequently across all job postings?
SELECT
    skill,
    count(skill) AS skill_count
FROM job_skills
GROUP BY skill
ORDER BY skill_count DESC
LIMIT 10; 


SELECT DISTINCT is_salary_disclosed
FROM jobs;

-- For jobs where salary is disclosed,
-- what is the average, minimum and maximum base salary — broken down by city?
SELECT 
	primary_city,
	avg(base_salary) AS avg_salary,
	MAX(base_salary) AS max_salary ,
    MIN(base_salary) AS min_salary
FROM  jobs
WHERE is_salary_disclosed = 1  
GROUP BY primary_city
ORDER BY avg_salary DESC;

-- For each city, how many unique job postings are there along with 
-- how many distinct skills are mentioned across those postings?
SELECT 
    c.primary_city,
    COUNT(DISTINCT c.job_id) AS total_jobs,
    COUNT(DISTINCT s.skill) AS unique_skills
FROM jobs c
JOIN job_skills s ON c.job_id = s.job_id
GROUP BY c.primary_city
ORDER BY total_jobs DESC;

-- Which companies demand the most diverse skill sets (i.e., require the widest range of unique skills)?
SELECT 
    c.company,
    COUNT(DISTINCT s.skill) AS unique_skills_demanded
FROM jobs c
JOIN job_skills s ON c.job_id = s.job_id
GROUP BY c.company
ORDER BY unique_skills_demanded DESC
LIMIT 10;

-- How many jobs require a specific skill (e.g., "SQL"), and what is the average salary for those jobs?
SELECT 
    COUNT(DISTINCT c.job_id) AS jobs_with_sql,
    AVG(c.base_salary) AS avg_salary
FROM jobs c
JOIN job_skills s ON c.job_id = s.job_id
WHERE s.skill = 'SQL'
  AND c.is_salary_disclosed = 1 ;
  
-- Which job posting platform (postedin) has the most listings
-- and how does salary disclosure rate differ across platforms?
 SELECT 
    postedin,
    COUNT(*) AS total_jobs,
    SUM(CASE WHEN is_salary_disclosed = 1 THEN 1 ELSE 0 END) AS salary_disclosed_count,
    ROUND(SUM(CASE WHEN is_salary_disclosed = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS disclosure_percentage
FROM jobs
GROUP BY postedin
ORDER BY total_jobs DESC;


-- What percentage of jobs disclose their salary vs. don't?
SELECT 
    is_salary_disclosed,
    COUNT(*) AS job_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM jobs), 2) AS percentage
FROM jobs
GROUP BY is_salary_disclosed;
  
-- Does average salary differ by experience level (fresher vs. mid vs. senior)?
SELECT 
    CASE 
        WHEN min_exp <= 2 THEN 'Fresher (0-2 yrs)'
        WHEN min_exp <= 5 THEN 'Mid (3-5 yrs)'
        ELSE 'Senior (5+ yrs)'
    END AS experience_level,
    AVG(base_salary) AS avg_salary,
    COUNT(*) AS job_count
FROM jobs
WHERE is_salary_disclosed = 1
GROUP BY experience_level
ORDER BY avg_salary DESC;


-- Which companies offer the highest average salary (only counting companies with at least 2 job postings, to avoid misleading single-job averages)?
SELECT 
    company,
    AVG(base_salary) AS avg_salary,
    COUNT(*) AS job_count
FROM jobs
WHERE is_salary_disclosed = 1
GROUP BY company
HAVING COUNT(*) >= 2
ORDER BY avg_salary DESC
LIMIT 10;