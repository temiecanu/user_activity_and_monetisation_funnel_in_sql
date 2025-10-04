# User Activity and Monetisation Funnel in SQL

## Project Overview

This SQL project explores user behaviour within an educational platform that uses a “trial-to-paid” monetisation model. The goal was to extract meaningful user engagement and monetisation metrics directly from relational data using optimised SQL queries. The results provide insights into student diligence and the effectiveness of new payment mechanics tested in an A/B experiment.

The project is divided into two main analytical tasks.

## Task 1: Identifying diligent students (`diligent_students.sql`)

**Objective**:

Determine the number of highly diligent students — users who have correctly solved at least 20 tasks (“peas”) in a given month.

**Source table (peas.csv)**:
 - st_id – student ID
 - timest – timestamp of the task
 - correct – whether the task was solved correctly
 - subject – subject area of the task

**Logic**:
I group the data by student ID and count the number of correctly solved tasks. If a student has 20 or more correct answers in the current month, they are marked as diligent.

## Task 2: Monetisation funnel analysis (`monetisation_funnel_metrics.sql`)

**Business context**:
The educational platform allows students to solve up to 30 tasks per day for free. For unlimited access, users must purchase a course. A new payment screen was tested in an experiment to assess its influence on monetisation metrics.

**Goal**:
Write a single SQL query that returns the following metrics split by control and test groups:
 - ARPU (Average Revenue Per User)
 - ARPAU (Average Revenue Per Active User)
 - CR to Purchase (conversion rate to purchase among all users)
 - CR to Purchase among Active Users
 - CR to Purchase in Math among Active Math Users

**Tables used**:
 - **peas.csv** – contains task interactions
 - **studs.csv** – contains student IDs and group labels for the A/B test
 - **checks.csv** – contains purchases (student ID, timestamp, amount, subject)
 
 **Definitions**:
 - Active User: Solved more than 10 tasks correctly in any subject.
 - Active Math User: Solved 2 or more tasks correctly in the math subject.
 - CR is computed as the number of payers divided by the relevant user base (e.g., total users, active users).
 - ARPU is based on all users; ARPAU is based on active users.

---

## Repository Structure

```
user_activity_and_monetisation_funnel_in_sql/
│
├── data/                      
│   ├── peas.csv                        # Task interactions data
│   ├── studs.csv                       # Student IDs and A/B test group labels
│   └── checks.csv                      # Purchase transactions
│
├── diligent_students.sql               # SQL script to identify diligent students
├── monetisation_funnel_metrics.sql     # SQL script for monetisation funnel metrics
├── README.md
```

---

## Usage

To reproduce the analysis:
1. Upload the provided `.csv` files into your local or cloud SQL environment.
2. Run the SQL scripts using any SQL IDE (e.g. DBeaver, DataGrip, or pgAdmin).
3. Review query results or export for further reporting.

---

## Author

Artemie Țurcanu — Data Analyst.