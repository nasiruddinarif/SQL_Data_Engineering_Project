/*
Question: What are the most optimal skills for data engineers - balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why? 
    - This approach higlhlights skills that balance market demand and financial reward. It weights core skill appropriately, rather than letting rare, outlier skills distort the results.
*/

SELECT 
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    --COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*)))/1_000_000, 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim  AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*
Here's the breakdown of the most optimal skills for data engineers, based on high demand and high salaries:

Top skills by Optimal Score:
1. Terraform leads the list with a $184k median salary and 193 postings, resulting in the highest overall "optimal score" of 0.97.
2. Python and SQL follow closely, with strong demand (7,000+ postings each) and solid median salaries ($135k and $130k respectively), yielding optimal scores of 0.95 and 0.91.
3. AWS, Airflow, Spark, and Snowflake also rank highly, reflecting their importance in the data engineering landscape, with optimal scores ranging from 0.91 to 0.82.
4. Kafka offers high compensation ($145k) and moderate demand (300 postings), resulting in an optimal score of 0.82.
5. Tools like Azure, Java, Scala, Git, Kubernetes, Databricks, Redshift, GCP, NoSQL, Hadoop, PySpark, MongoDB, Docker, Go, R, BigQuery, and GitHub round out the top 25 skills with varying combinations of demand and salary.

┌────────────┬───────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ ln_demand_count │ optimal_score │
│  varchar   │    double     │     double      │    double     │
├────────────┼───────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │             5.3 │          0.97 │
│ python     │      135000.0 │             7.0 │          0.95 │
│ sql        │      130000.0 │             7.0 │          0.91 │
│ aws        │      137320.0 │             6.7 │          0.91 │
│ airflow    │      150000.0 │             6.0 │          0.89 │
│ spark      │      140000.0 │             6.2 │          0.87 │
│ snowflake  │      135500.0 │             6.1 │          0.82 │
│ kafka      │      145000.0 │             5.7 │          0.82 │
│ azure      │      128000.0 │             6.2 │          0.79 │
│ java       │      135000.0 │             5.7 │          0.77 │
│ scala      │      137290.0 │             5.5 │          0.76 │
│ git        │      140000.0 │             5.3 │          0.75 │
│ kubernetes │      150500.0 │             5.0 │          0.75 │
│ databricks │      132750.0 │             5.6 │          0.74 │
│ redshift   │      130000.0 │             5.6 │          0.73 │
│ gcp        │      136000.0 │             5.3 │          0.72 │
│ nosql      │      134415.0 │             5.3 │          0.71 │
│ hadoop     │      135000.0 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │             4.9 │          0.67 │
│ docker     │      135000.0 │             5.0 │          0.67 │
│ go         │      140000.0 │             4.7 │          0.66 │
│ r          │      134775.0 │             4.9 │          0.66 │
│ bigquery   │      135000.0 │             4.8 │          0.65 │
│ github     │      135000.0 │             4.8 │          0.65 │
└────────────┴───────────────┴─────────────────┴───────────────┘
  25 rows                                            4 columns

*/
