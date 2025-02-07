# SumUp_takehome


## Overview
This project outlines a data pipeline designed to process Excel files received from stakeholders, transform them into a structured format, and perform analysis to generate key performance indicators (KPIs). The pipeline leverages PostgreSQL for local development and utilizes dbt (data build tool) for data modeling and transformations.

## Workflow
1) Data Ingestion:
    - Receive .xlsx files from stakeholders containing raw data.
    - Convert these Excel files into .csv format using a Python script, as PostgreSQL cannot directly ingest Excel files.
    - 
2) Data Loading:
   - Load the transformed .csv files into PostgreSQL, creating source tables.
   - During this process, sensitive information such as card_number and cvv is excluded to adhere to data privacy standards.

3) Data Modeling with dbt:
   - Staging Models:
     - Combine data from the three source tables into a unified staging model representing all transaction information.
     - Configure this staging model as an incremental model in dbt to process only new or updated records, enhancing efficiency.
   - KPI Models:
     - Develop individual dbt models to address specific business questions, each materialized as a materialized view.
     - This approach ensures that stakeholders access the most recent data upon querying, with materialized views refreshed based on the staging model's update schedule.
     
4) Handling Top 10 Queries:
   - For analyses requiring the top 10 entries, implement ranking within the dbt models.
   - Utilize the RANK() function to assign ranks, ensuring that entries with tied values are appropriately handled, even if it results in more than 10 entries being returned.

## Local Development Environment
- Database: PostgreSQL is used for local development due to its robustness and compatibility with dbt. In a production environment, cloud-based data warehouses like Amazon Redshift or Google BigQuery would be preferred for scalability and performance.

- Containerization:
  - A Docker container is set up to host the PostgreSQL database and dbt environment, ensuring consistency across development setups.

## Considerations
- Data Privacy: Sensitive information is excluded during the data loading process to comply with data protection regulations.

- Data Freshness: Materialized views are refreshed based on the staging model's schedule to ensure stakeholders access the most recent data.

- Performance: Incremental models in dbt are utilized to optimize performance by processing only new or updated records.

## Next Step
- Better Python logger script and potential Datadog integration for monitoring
- Data Lineage Diagram
