# 🏦 Bank Customer Churn Analysis & Predictive Insights

[![Data Analyst Portfolio](https://img.shields.io/badge/Portfolio-Data%20Analyst-blue?style=flat-square&logo=github)](https://github.com/)
[![SQL](https://img.shields.io/badge/SQL-MySQL%20Workbench-orange?style=flat-square&logo=mysql)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/Visualization-Power%20BI-yellow?style=flat-square&logo=powerbi)](https://powerbi.microsoft.com/)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=flat-square)](https://github.com/)

An end-to-end data analytics project investigating customer attrition for a retail bank. This project spans raw data ingestion, SQL-based data cleaning and exploratory data analysis (EDA), and an interactive Power BI executive dashboard designed to uncover key drivers of customer churn and deliver actionable retention strategies.

---

## 📋 Table of Contents
1. [Project Overview & Business Problem](#-project-overview--business-problem)
2. [Project Objectives](#-project-objectives)
3. [Tools & Technologies Used](#-tools--technologies-used)
4. [Dataset Description](#-dataset-description)
5. [Project Workflow](#-project-workflow)
6. [Data Cleaning & Preparation](#-data-cleaning--preparation)
7. [SQL Analysis & Key Questions Answered](#-sql-analysis--key-questions-answered)
8. [Key Performance Indicators (KPIs)](#-key-performance-indicators-kpis)
9. [Power BI Dashboard Preview](#-power-bi-dashboard-preview)
10. [Key Findings & Business Insights](#-key-findings--business-insights)
11. [Strategic Recommendations](#-strategic-recommendations)
12. [Challenges & Limitations](#-challenges--limitations)
13. [Repository Structure & Navigation](#-repository-structure--navigation)
14. [How to Reproduce This Analysis](#-how-to-reproduce-this-analysis)
15. [Author & Acknowledgments](#-author--acknowledgments)

---

## 🎯 1. Project Overview & Business Problem

Customer acquisition cost in the banking sector is significantly higher than customer retention. Leadership identified an escalating attrition trend where profitable accounts were closing their accounts unexpectedly. 

* **The Business Problem**: The bank is experiencing an overall customer churn rate of **20.37%** (2,037 out of 10,000 customers). Without targeted intervention, this ongoing attrition erodes fee income, diminishes long-term customer lifetime value (LTV), and concentrates risk in high-value asset brackets.
* **The Solution**: Conduct a granular multi-dimensional analysis using SQL and Power BI to identify high-risk customer segments, evaluate product adoption bottlenecks, and equip management with data-driven retention triggers.

---

## 🎯 2. Project Objectives

* Calculate the baseline churn rate and quantify financial losses across account balances and salaries.
* Evaluate regional performance to determine if geographic concentration drives attrition.
* Analyze product adoption thresholds to understand why customers utilizing multiple products are leaving.
* Assess customer engagement impact (active membership status and credit card ownership).
* Investigate demographic risk factors (age cohorts and gender) and credit score tiers.

---

## 🛠️ 3. Tools & Technologies Used

* **Database & Querying**: MySQL Workbench (Data cleaning, schema alteration, aggregation queries, CTEs, and window functions).
* **Data Visualization & Business Intelligence**: Power BI Desktop (DAX measures, interactive filtering, slicers, and executive dashboard layout).
* **Data Processing & Spreadsheet Tools**: Microsoft Excel (Data verification and initial profiling).
* **Version Control & Documentation**: Git & GitHub (Repository architecture, Markdown documentation, and portfolio presentation).

---

## 📊 4. Dataset Description

The dataset comprises **10,000 customer records** with the following key attributes:
* **Demographics**: `Geography` (France, Germany, Spain), `Gender`, `Age`.
* **Banking Profile**: `CreditScore`, `Tenure` (years with bank), `Balance` (account balance), `NumOfProducts` (bank products held).
* **Engagement Indicators**: `HasCrCard` (1 = Yes, 0 = No), `IsActiveMember` (1 = Yes, 0 = No), `EstimatedSalary`.
* **Target Variable**: `Exited` (1 = Churned, 0 = Retained).

*Limitations*: The dataset represents a cross-sectional snapshot without explicit time-series timestamps for exact churn dates, limiting seasonality analysis.

---

## 🔄 5. Project Workflow

```mermaid
graph TD
    A[Raw CSV Data <br> 10,000 Records] -->|Import & Staging| B[(MySQL Database)]
    B -->|Data Cleaning & Type Casting| C[SQL Exploratory Data Analysis]
    C -->|Aggregations & KPI Queries| D[Power BI Data Model & DAX]
    D -->|Interactive Executive Dashboard| E[Actionable Insights & Recommendations]
