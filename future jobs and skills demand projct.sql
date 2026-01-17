/*
== PROJECT: Future jobs and skills demand EDA+ churn analysis 
    DATA SOURCE: Kaggle ( synthetic dataset for 2025 )
*/

/*
=============== BASIC DATA UNDERSTANDING ============
*/

-- checking data import 

select*
from futurejobs ;
DESCRIBE futurejobs;

-- check total no of records

SELECT COUNT(*) AS total_records
FROM futurejobs;

/*
============= KEY BUSINESS KPIs (OVERVIEW) ============
*/

-- Total job postings

select count(*) AS total_job_postings
 FROM futurejobs;

-- Average salary 

SELECT ROUND(AVG(salary_usd), 2) AS avg_salary_usd
FROM futurejobs;

-- average salary by industry

SELECT industry,
 ROUND(AVG(salary_usd), 2) AS avg_salary
 FROM futurejobs
 GROUP BY industry
 ORDER BY avg_salary DESC;
 
 -- Percentage of remote jobs
 
 SELECT ROUND(SUM(CASE WHEN remote_option = 'Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)
 AS remote_job_percentage
 from futurejobs;
 
 -- job distribution by company size 
 
SELECT company_size,
COUNT(*) AS job_count 
from futurejobs
GROUP BY company_size
ORDER BY  job_count DESC;

/*  
======================== EXPLORATORY DATA ANALYSIS (EDA) =========================
*/

-- Jobs by industry 

SELECT industry ,
COUNT(*) AS total_jobs
FROM futurejobs
GROUP BY industry
ORDER BY total_jobs;

-- TOP 10 job location

SELECT location ,
COUNT(*) AS job_count
FROM futurejobs
GROUP BY location
ORDER BY job_count DESC
 LIMIT 10;

-- Monthly job posting trend

SELECT date_format(posting_date, '%Y,%m') AS month,
COUNT(*) AS job_postings
FROM futurejobs
GROUP BY month
ORDER BY month;

-- Salary Distribution By Industry

SELECT industry ,
MIN(salary_usd) AS min_salary,
MAX(salary_usd) AS max_salary,
ROUND(AVG(salary_usd),2) AS avg_salary
FROM futurejobs
GROUP BY industry;

-- Remote VS onsite jobs count

SELECT remote_option,
COUNT(*) AS job_count
FROM futurejobs
GROUP BY remote_option;

-- Average salary : Remote VS onsite

SELECT remote_option,
ROUND(AVG(salary_usd),2) AS avg_salary
FROM futurejobs
GROUP BY remote_option;

-- TOP 10 Highest paying job titles

SELECT job_title,
ROUND(AVG(salary_usd),2) AS avg_salary
FROM futurejobs
GROUP BY job_title 
ORDER BY  avg_salary DESC
LIMIT 10;

/* 
====================== SKILLS NORMALIZATION
                (REQUIRED FOR SKILL ANALYSIS) ===============================
*/

-- Create skill-level table

CREATE TABLE IF NOT EXISTS job_skills (
job_id int ,
skill VARCHAR(50)
);

-- Insert split skills from comma-separated column

INSERT INTO job_skills (job_id, skill)
SELECT
    job_id,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(skills_required, ',', numbers.n), ',', -1)) AS skill
FROM futurejobs
JOIN (
    SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
    SELECT 4 UNION ALL SELECT 5
) numbers
ON CHAR_LENGTH(skills_required)
 - CHAR_LENGTH(REPLACE(skills_required, ',', '')) >= numbers.n - 1;
 
 /*
 ====================== SKILLS DEMAND ANALYSIS ========================
 */
 
 -- TOP 15 most demanded skills
 
 SELECT skill, 
 count(*) AS demand_count
 FROM job_skills
 GROUP BY skill
 ORDER BY demand_count DESC 
 LIMIT 15;
 
 -- skills demand by industry 
 
SELECT 
 js.skill, 
fj.industry,
 count(*) AS skill_count
 FROM job_skills js
 JOIN futurejobs fj
 on js.job_id = fj.job_id
 GROUP BY js.skill, fj.industry
 ORDER BY fj.industry,skill_count DESC ;
 
-- skills required for remote jobs

SELECT 
 js.skill, 
 count(*) AS remote_skill_count
 FROM job_skills js
 JOIN futurejobs fj
 on js.job_id = fj.job_id
 WHERE fj.remote_option= 'Yes'
 GROUP BY js.skill
 ORDER BY remote_skill_count DESC 
 LIMIT 10;

-- average salary by skill

SELECT 
 js.skill, 
 ROUND(AVG(fj.salary_usd),2) AS avg_salary
 FROM job_skills js
 JOIN futurejobs fj
 on js.job_id = fj.job_id
 GROUP BY js.skill
 ORDER BY avg_salary DESC 
 LIMIT 10;

/*
============================= CHURN ANALYSIS SETUP==============================
                    CHURN TYPE: HIRING/ TALENT DEMAND CHURN
                    
*/                
  
  -- create simulated hiring entity (company identifier)
   
ALTER TABLE futurejobs
ADD COLUMN hiring_entity_id INT;

-- assign one hiring entity per 10 job postings ( synthetic logic)

UPDATE futurejobs
SET hiring_entity_id = FLOOR(( job_id - 1) / 10)+1;

   
   /*
   ===================== HIRING CHURN ANALYSIS ========================
                           (CORE CHURN METRIC)
  */
  
  -- identify last activity date per hiring 
  
  SELECT  hiring_entity_id ,
  MAX(posting_date) AS last_posting_date
  FROM futurejobs
  GROUP BY  hiring_entity_id ; 
  
  -- classify active VS churned hiring entities
  
  SELECT  hiring_entity_id ,
  MAX(posting_date) AS last_posting_date,
  CASE WHEN MAX(posting_date)< DATE_SUB('2025-12-31', INTERVAL 60 DAY)
  THEN 'churned'
  ELSE ' active'
  END AS churn_status
FROM futurejobs
  GROUP BY  hiring_entity_id ; 
  
  -- KPI: hiring churn rate (%)
  
  SELECT ROUND(SUM( 
  CASE WHEN churn_status = 'churned' THEN 1 ELSE 0 END)*100/ COUNT(*),2)
  AS hiring_churn_rate_percentage
  from ( SELECT hiring_entity_id ,
  CASE WHEN  MAX(posting_date)< DATE_SUB('2025-12-31', INTERVAL 60 DAY)
  THEN 'churned'
  ELSE ' active'
  END AS churn_status
FROM futurejobs
  GROUP BY  hiring_entity_id)
  churn_summary;
  
  /*
  ============================= CHURN ROOT CAUSE ANALYSIS ====================
  */
  
  -- churned hiring entities by industry
  
  SELECT industry,
  COUNT( DISTINCT  hiring_entity_id) AS churned_entities
  FROM futurejobs 
  WHERE  hiring_entity_id IN (
   SELECT  hiring_entity_id 
   FROM futurejobs
   GROUP BY hiring_entity_id 
  HAVING MAX(posting_date)< DATE_SUB('2025-12-31', INTERVAL 60 DAY)
  )
  GROUP BY industry
  ORDER BY churned_entities DESC;
  
  -- Churned hiring entities by company size
  
    SELECT company_size,
  COUNT( DISTINCT  hiring_entity_id) AS churned_entities
  FROM futurejobs 
  WHERE  hiring_entity_id IN (
   SELECT  hiring_entity_id 
   FROM futurejobs
   GROUP BY hiring_entity_id 
  HAVING MAX(posting_date)< DATE_SUB('2025-12-31', INTERVAL 60 DAY)
  )
  GROUP BY company_size;
  
  
  /*
  ===================== SKILL DEMAND CHURN ==================================
				        (SKILL ATTRITION)
  
  */
  
  -- compare skill demand Q1 VS Q4
  
  SELECT
    js.skill,
    COUNT(CASE WHEN MONTH(fj.posting_date) <= 3 THEN 1 END) AS q1_demand,
    COUNT(CASE WHEN MONTH(fj.posting_date) >= 10 THEN 1 END) AS q4_demand,
    ROUND(
        (COUNT(CASE WHEN MONTH(fj.posting_date) >= 10 THEN 1 END) * 100.0) /
        NULLIF(COUNT(CASE WHEN MONTH(fj.posting_date) <= 3 THEN 1 END), 0),
        2
    ) AS retention_percentage
FROM job_skills js
JOIN futurejobs fj
ON js.job_id = fj.job_id
GROUP BY js.skill
ORDER BY retention_percentage;
  
 /*
 ==================== REMOTE WORK CHURN ==============================
 
*/
  
  -- Remote job decline by industry (H1 VS H2)
  
  SELECT industry,
  COUNT( CASE WHEN remote_option = 'Yes'
  AND posting_date<='2025-06-30' THEN 1 END ) AS first_half_remote,
  COUNT( CASE WHEN remote_option = 'Yes'
  AND posting_date>'2025-06-30' THEN 1 END ) AS second_half_remote
  FROM futurejobs
  GROUP BY industry;
  
  
  
  
  
  
  