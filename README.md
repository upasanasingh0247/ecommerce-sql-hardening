# E-Commerce Database Architecture & SQL Hardening

## 📌 Project Overview
This project demonstrates the design, optimization, and hardening of a relational database for an e-commerce platform using PostgreSQL. The goal of this phase was to go beyond basic data storage and implement enterprise-level security, data integrity, and high-performance querying.

## 🛠️ Tech Stack
* **Database:** PostgreSQL
* **Tools:** pgAdmin, SQL

## 🚀 Key Features & Implementations

### 1. Data Integrity & Validation
* Implemented `ENUM` types to enforce strict categorization (e.g., locking order statuses to 'Pending', 'Shipped', 'Delivered').
* Applied `CHECK` constraints to ensure logical data entry (e.g., preventing negative inventory counts or prices).

### 2. Automated Security & Auditing
* Built automated **Triggers** and **Audit Tables** acting as background security cameras.
* Every change or deletion in the primary tables is automatically logged in historical tables without requiring manual user input.

### 3. Transaction Safety
* Utilized `BEGIN`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT` commands to create safe transaction blocks.
* Designed failsafes to prevent partial data updates (e.g., an order being placed but inventory failing to update).

### 4. Advanced Analytics (Window Functions)
* Developed reporting queries using `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` for accurate data tiering.
* Created live running totals (bank passbook style) using `SUM() OVER(...)`.
* Calculated "days between purchases" for customer retention metrics using time-traveling `LAG()` and `LEAD()` functions.

### 5. Performance Optimization
* Diagnosed slow query execution using `EXPLAIN ANALYZE`.
* Eliminated inefficient `Seq Scans` by engineering Single and Composite `INDEXES`, significantly reducing query execution time for multi-column searches.

## 📂 Repository Structure
* `01_schema_setup.sql` - Table creation, ENUMs, and Constraints.
* `02_audit_triggers.sql` - Trigger functions and historical logging tables.
* `03_transactions.sql` - SAVEPOINT and rollback examples.
* `04_advanced_analytics.sql` - Window functions and running totals.
* `05_indexing_optimization.sql` - Single and Composite Indexes.
