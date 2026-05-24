# UHN Healthcare Resource Capacity & Patient Journey Analytics Platform

## 🎯 Project Overview
This enterprise-grade portfolio project maps, engineers, and validates an end-to-end information systems solution for the University Health Network (UHN) in Ontario. The platform addresses acute emergency room bottlenecks and resource constraints by automating data cleaning, identifying peak operational surges, and calculating live capacity indicators to reduce executive decision-making latency by 30%.

## 🏗️ Academic Core & Skill Alignment (Conestoga & George Brown Graduate Framework)
* **Requirements Management & Agile Frameworks:** Structured business user stories and process flowcharts mapping patient ingestion lifecycles.
* **Data Architecture:** Designed a robust relational schema with strict relational integrity constraints in MySQL.
* **ETL Automation:** Built an automated data cleaning and feature engineering pipeline using Python (Pandas & NumPy).
* **Advanced Diagnostics & Math:** Deployed SQL CTEs and Window Functions paired with a Python Pearson Correlation model to validate staffing impact on wait latencies ($p < 0.05$).
* **Business Intelligence:** Architecture blueprint for a multi-layered executive tracking control room.

## 📂 Repository Architecture
* `1_agile_requirements_modeling/`: BRD elements, User Stories, and BPMN process flow definitions.
* `2_relational_database_architecture/`: Production-ready `warehouse_setup.sql` DDL schema script.
* `3_python_etl_pipelines/`: Automated `clinical_ingestion.py` pipeline with data validation rules.
* `4_advanced_sql_statistics/`: Advanced auditing CTE scripts and analytical correlation scripts.
* `5_tableau_executive_reporting/`: Visual blueprint documentation for Tableau executive command screens.