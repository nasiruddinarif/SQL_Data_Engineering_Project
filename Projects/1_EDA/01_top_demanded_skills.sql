/*
Question: What are the most in-demand skills for data engineers?
- Identify the top 10 most in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the job market, providing insights
the most valuable skills for data engineers seeking remote opportunities. 
This information can help data engineers prioritize skill development and stay competitive 
in the job market.
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim  AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most in-demand skills for data engineers based on the query results:
- SQL and Python are the top two skills, indicating their importance in data engineering roles.
- With the increasing adoption of cloud platforms, skills in AWS, Azure, and GCP are also highly sought after.
- The presence of Spark, Airflow, Snowflake, and Databricks in the top 10 list highlights the significance of big data processing, workflow orchestration, and modern data warehousing technologies in the field of data engineering.
- The demand for Java suggests that traditional programming skills are still relevant in data engineering, especially for building scalable data pipelines and applications.

Key Takeaways:
1. SQL and Python are essential skills for data engineers, as they are widely used for data manipulation, analysis, and building data pipelines.
2. Cloud platforms like AWS, Azure, and GCP are in high demand, reflecting the growing trend of cloud-based data engineering solutions.
3. Big data processing frameworks (Spark) and workflow orchestration tools (Airflow) are crucial for managing large-scale data processing and ETL workflows.
4. Modern data warehousing technologies (Snowflake, Databricks) are becoming increasingly important for data engineers to efficiently store, process, and analyze large datasets.
Overall, data engineers should focus on developing a strong foundation in SQL and Python, while also gaining expertise in cloud platforms, big data processing frameworks, workflow orchestration tools, and modern data warehousing technologies to stay competitive in the job market.
*/

┌────────────┬──────────────┐   
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘
  10 rows         2 columns
