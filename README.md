# Data Analyst Job Market — India (2024)

An end-to-end data analytics project exploring the Data Analyst job market in India, built across **Python, SQL, Excel, and Power BI** to demonstrate a full analytics-stack workflow — from raw data to an interactive dashboard.

![Status](https://img.shields.io/badge/status-complete-brightgreen) ![Python](https://img.shields.io/badge/Python-Pandas-blue) ![SQL](https://img.shields.io/badge/SQL-MySQL-orange) ![Excel](https://img.shields.io/badge/Excel-PivotTables-green) ![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Dashboard Preview](#-dashboard-preview)
- [Dataset](#️-dataset)
- [How to Use This Project](#-how-to-use-this-project)
- [Key Findings](#-key-findings)
- [Key Takeaways](#-key-takeaways)
- [Data Quality Observations](#-data-quality-observations)
- [Methodology (Detailed)](#-methodology-detailed)
- [Tools & Technologies](#️-tools--technologies)
- [Repository Structure](#-repository-structure)
- [About](#-about)

---

## 📌 Project Overview

Data Analyst hiring in India spans hundreds of companies, cities, and skill requirements — but raw job-posting data is messy, inconsistent, and hard to act on. This project cleans, models, and analyzes **1,456 real Data Analyst job postings** (sourced from Kaggle, listed as of 7th July 2024) to answer practical questions a hiring team or job-seeker would actually ask: Which cities have the most openings? Which skills are in demand? How much does experience actually move the needle on salary?

The project intentionally uses **four different tools for four different jobs** — each chosen for what it's actually good at — to mirror a real analyst's workflow and demonstrate proficiency across the stack.

| Tool | Role in the Project |
|---|---|
| **Python (Pandas)** | Data cleaning, deduplication, feature engineering |
| **MySQL** | Relational modeling and analytical querying |
| **Excel** | Quick summary tables, PivotTables, and charts |
| **Power BI** | Interactive, cross-filterable dashboard |

---

## 🖼️ Dashboard Preview



The dashboard is fully interactive — city, platform, and experience-level slicers cross-filter every visual on the page in real time.

---

## 🗂️ Dataset

- **Source:** [Kaggle — Data Analyst Job Opening in India (7th July 2024)](https://www.kaggle.com/)
- **Raw size:** ~1,561 rows
- **Cleaned size:** 1,456 rows × 17 columns
- **Skills table:** 3,239 normalized (job_id, skill) rows after cleanup

---

## 🚀 How to Use This Project

### Prerequisites
- [Python 3.x](https://www.python.org/) with `pandas` (only needed if re-running the cleaning step)
- [MySQL Workbench](https://dev.mysql.com/downloads/workbench/) (or any MySQL client)
- [Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494) (Windows) + [MySQL Connector/NET](https://dev.mysql.com/downloads/connector/net/)
- Microsoft Excel (to view `excel_summary.xlsx`)

### Steps

1. **Clone this repository**
   ```bash
   git clone https://github.com/<your-username>/data-analyst-jobs-india-analysis.git
   ```

2. **Set up the database**
   - Open MySQL Workbench and run [`data.sql`](./data.sql) — this creates the `data_analyst_jobs_india` schema, builds the `jobs` and `job_skills` tables, and loads the cleaned CSV data.
   - Update the `LOAD DATA LOCAL INFILE` file path in the script to match where you've saved `cleaned_data_analyst_jobs_india.csv` locally.

3. **Explore the SQL analysis**
   - All 10 analytical queries are included in `data.sql`, fully commented — run them individually in Workbench to reproduce every number in this README.

4. **Open the Power BI dashboard**
   - Open `data_analyst_jobs_india_dashboard.pbix` in Power BI Desktop.
   - On first open, you'll be prompted to re-enter your local MySQL credentials (username/password) since the dashboard connects live to the database rather than a static file.
   - Use the **City**, **Platform**, and **Experience Level** slicers at the top to filter the dashboard interactively.

5. **(Optional) Re-run the Python cleaning step**
   - The full cleaning notebook logic is summarized in the [Methodology](#-methodology-detailed) section below; re-run it against the raw Kaggle CSV if you want to reproduce `cleaned_data_analyst_jobs_india.csv` from scratch.

---

## 🔑 Key Findings

| Question | Result |
|---|---|
| **Total job postings analyzed** | 1,456 |
| **Top hiring city** | Bangalore — 345 postings |
| **Top 3 hiring cities** | Bangalore (345), Mumbai (213), Chennai (138) |
| **#1 in-demand skill** | SQL — 262 postings |
| **Top 5 skills** | SQL, Python, Power BI, Tableau, Data Management |
| **Salary disclosure rate** | Only 22.2% of postings disclose salary (323 of 1,456) |
| **Most active platform** | Naukri — 1,161 of 1,456 postings (79.7%) |
| **Salary by experience** | Fresher (0–2 yrs): ₹3.74L avg · Mid (3–5 yrs): ₹6.54L avg · Senior (5+ yrs): ₹11.86L avg |
| **SQL-skill jobs, avg. salary** | 42 disclosed postings requiring SQL, averaging ₹3.35L |
| **Most diverse-skill employers** | Diverse Lynx and Coders Brain Pvt Ltd — 21 unique skills demanded each |

**Salary by top hiring city** (average base salary, disclosed postings only):

| City | Avg. Base Salary |
|---|---|
| Noida | ₹7.35L |
| Pune | ₹6.62L |
| Gurgaon | ₹5.88L |
| Mumbai | ₹5.75L |
| Bangalore | ₹5.66L |
| Hyderabad | ₹5.56L |
| Chennai | ₹5.33L |
| Delhi | ₹5.19L |

*Note: Bangalore has by far the most job volume, but Noida and Pune edge it out slightly on average disclosed salary — a useful nuance for job-seekers optimizing for pay over volume.*

---

## 🎯 Key Takeaways

- **Bangalore dominates volume** (24% of all postings) but doesn't pay the most on average — Noida and Pune post higher average disclosed salaries, a gap worth flagging to job-seekers chasing pay over listing count.
- **SQL is the single most in-demand skill**, appearing in 262 postings — well ahead of Python (150) and Power BI (130), confirming it as the highest-leverage skill to prioritize.
- **Salary transparency is low**: fewer than 1 in 4 postings (22.2%) disclose compensation, which limits how confidently salary benchmarks can be generalized across the full market.
- **Experience compounds pay significantly**: average base salary more than triples from Fresher (₹3.74L) to Senior (₹11.86L) level.
- **Naukri is the dominant hiring channel**, hosting nearly 80% of all postings in this dataset — but its salary disclosure rate (27.6%) is still low relative to what job-seekers would want.
- **Data quality matters**: catching and documenting outliers (like the ₹50K vs. ₹96L salary gap) rather than silently deleting them preserves analytical honesty — a habit worth carrying into any real analyst role.

---

## ⚠️ Data Quality Observations

Three salary outliers were investigated during analysis:

1. **Job ID 1373** (Xpheno, Data Analyst, 2–5 yrs exp): base salary ₹50,000 vs. max salary ₹96,00,000 — an extreme, implausible gap, most likely a unit or data-entry error at the source.
2. **Job ID 460** (InnovAccer, Lead Data Analyst, 5–6 yrs exp): base salary (₹32,00,000) *exceeds* max salary (₹25,00,000) — a logical impossibility, likely swapped values at the source.
3. **Job ID 1057** (Rocket Fast Recruiter, Data Analyst, 10–20 yrs exp, ₹90,00,000–₹2,25,00,000): flagged initially but **ruled not an anomaly** — plausible for a senior-level role at that experience range.

These rows were retained (not deleted) to preserve data integrity, but are called out here as known limitations of the source data.

---

## 🔬 Methodology 

<details>
<summary><strong>Step 1 — Data Cleaning (Python / Pandas)</strong> — click to expand</summary>

<br>

Performed in Google Colab, with the cleaned dataset persisted to Google Drive.

**Key steps:**
- Dropped the redundant `Unnamed: 0` index column
- Removed **71 duplicate rows** (verified count — an earlier estimate of 129 was inflated because the unremoved index column made every row appear artificially unique)
- Dropped the raw `experience` text column after parsing it into `min_exp` / `max_exp`, and removed 34 rows too sparse to parse reliably
- Created an `is_salary_disclosed` boolean flag to distinguish disclosed vs. undisclosed compensation
- Extracted a clean `primary_city` field and built a `location_type` category (e.g., single city vs. multi-city vs. remote)
- Normalized `skills_list` to Title Case with an abbreviation-correction dictionary (`Sql → SQL`, `Power Bi → Power BI`, etc.)
- Added a `has_rating` boolean flag for company review data
- Standardized all column names to `snake_case`

**Output:** `cleaned_data_analyst_jobs_india.csv` (1,456 rows × 17 columns)

</details>

<details>
<summary><strong>Step 2 — Relational Modeling & Analysis (SQL / MySQL)</strong> — click to expand</summary>

<br>

Built a two-table relational schema in MySQL Workbench (`data_analyst_jobs_india`):

- **`jobs`** — one row per job posting (job_id, title, company, experience range, salary range, location, rating, platform, etc.)
- **`job_skills`** — a normalized junction table (job_id, skill), one row per skill per job, linked via foreign key

**Data quality fix:** Mid-project, **1,028 rows** in `job_skills` were found to contain generic role-description noise (e.g., "Data Analyst," "Analytics," "Analytical" — words scraped from the job title, not actual skills). These were removed via a targeted `DELETE` query, and all downstream skill queries were re-run against the cleaned table.

All 10 core queries are documented in [`data.sql`](./data.sql), covering city-wise job counts, skill frequency, salary-by-city, city-skill diversity via JOIN, top diverse-skill employers, SQL-skill filtering, platform-wise disclosure rates, experience-bucketed salary (via `CASE WHEN`), and top-paying companies (filtered to `COUNT ≥ 2` to avoid single-job skew).

</details>

<details>
<summary><strong>Step 3 — Excel: Summary Tables & Charts</strong> — click to expand</summary>

<br>

To demonstrate spreadsheet fluency alongside SQL and Power BI, four deliverables were built using PivotTables and static summary tables:

- City-wise job count (Top 10 cities + "Others" bucket) — bar chart
- Top technical skills — bar chart
- Salary disclosure rate — pie chart
- City-wise average salary — bar chart

*(PivotCharts that referenced live pivot rows caused unintended full-dataset charting; this was resolved by building static manual summary tables alongside the pivots and charting those directly.)*

</details>

<details>
<summary><strong>Step 4 — Power BI: Interactive Dashboard</strong> — click to expand</summary>

<br>

The final deliverable: a fully interactive, cross-filterable dashboard connecting **live to the MySQL database** (rather than a flat file), demonstrating relational data modeling inside Power BI itself.

**Build details:**
- Connected directly to MySQL (`jobs` + `job_skills` tables) via the MySQL database connector
- Modeled a **Many-to-One** relationship on `job_id` (job_skills → jobs)
- Created a custom DAX column, `Experience Level`, bucketing `min_exp` into Fresher / Mid / Senior
- Built **7 visuals**: Total Jobs, Avg. Base Salary, Salary Disclosure Rate (donut), Most In-Demand Skills, Jobs by City (Top 10), Jobs by Platform, and Avg. Salary by Experience Level
- Added **3 interactive slicers**: City, Platform, and Experience Level, enabling full cross-filtering across every visual
- Applied a consistent color theme, clean card styling, and a titled, grid-aligned layout for a polished, presentation-ready look

**File:** [`data_analyst_jobs_india_dashboard.pbix`](./data_analyst_jobs_india_dashboard.pbix)

</details>

---

## 🛠️ Tools & Technologies

`Python` `Pandas` `Google Colab` `MySQL` `MySQL Workbench` `Microsoft Excel` `Power BI Desktop` `DAX` `Google Drive`

---

## 📁 Repository Structure

```
data-analyst-jobs-india-analysis/
├── cleaned_data_analyst_jobs_india.csv     # Cleaned dataset (Python output)
├── data.sql                                # Schema + all 10 analytical queries
├── data_analyst_jobs_india_dashboard.pbix  # Power BI dashboard
├── excel_summary.xlsx                      # PivotTables & charts
├── dashboard_preview.png                   # Dashboard screenshot (add your own)
└── README.md
```

---

## 👤 About

Built as a portfolio project to demonstrate an end-to-end analytics workflow — from messy raw data to a decision-ready, interactive dashboard — using the full standard analyst toolkit.
