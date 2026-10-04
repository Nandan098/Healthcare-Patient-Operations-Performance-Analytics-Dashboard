# Healthcare Patient Operations & Performance Analytics Dashboard

An end-to-end healthcare analytics project built with **SQL, Python, SQLite, and Power BI** to analyze patient encounters, operational performance, utilization, financial activity, and potential anomalies

---

##  Project Overview

Healthcare providers generate data across appointments, emergency visits, admissions, diagnoses, physicians, departments, and financial activity.

The challenge for an analyst is not simply to create charts. The analyst needs to:

- extract data from multiple tables
- validate data quality
- clean and transform the data
- identify trends and anomalies
- create meaningful healthcare KPIs
- communicate findings through dashboards
- translate analysis into operational recommendations

This project follows that complete workflow:

```text
Raw Healthcare Data
        ↓
SQLite Database
        ↓
SQL Data Validation
        ↓
SQL Business Analysis
        ↓
Python Cleaning & Enrichment
        ↓
Trend & Anomaly Analysis
        ↓
Power BI Dashboard
        ↓
Business Insights
```

---

##  Business Problem

The project is designed from the perspective of a Data Analyst supporting a healthcare provider organization.

Management wants to understand:

1. **How patient demand is changing over time**
2. **Which departments handle the highest patient volumes**
3. **Where waiting time and length of stay are elevated**
4. **Which diagnoses contribute most to patient activity**
5. **Where readmissions are concentrated**
6. **How billing activity varies across departments and encounters**
7. **Which records or operational patterns deserve further review**

The project therefore combines **operational analytics, healthcare KPIs, data quality, and anomaly analysis**.

---

# Dataset

The dataset is synthetic, but it is deliberately designed **not to be equally weighted**.

### Dataset scale

| Entity | Volume |
|---|---:|
| Patients | **15,000** |
| Encounters | **25,370** |
| Providers | **170+** |
| Departments | **10** |
| Diagnosis Categories | **15** |
| Study Period | **Jan 2024 – Sep 2026** |

### Main tables

| Table | Purpose |
|---|---|
| `Patients` | Patient-level demographics and payer information |
| `Encounters` | Main healthcare encounter fact table |
| `Physicians` | Provider and specialty information |
| `Departments` | Department and service-line reference |
| `Diagnosis_Catalog` | Diagnosis code reference |

### Key encounter fields

The encounter table contains fields such as:

- Encounter ID
- Patient ID
- Service Date
- Department
- Provider
- Encounter Type
- Encounter Status
- Primary Diagnosis
- Wait Time
- Length of Stay
- Billed Amount
- Paid Amount
- 30-day Readmission Flag

---

## Why the Dataset Is Non-Uniform

A common problem with portfolio datasets is that every category is artificially balanced.

This project intentionally avoids that.

### Patient utilization

Most patients have relatively few encounters, while a smaller subset returns repeatedly.

```text
Most patients     → 1 encounter
Smaller group     → 2–3 encounters
Smaller group     → 4–6 encounters
Small tail        → many encounters
```

### Department volume

Departments do not have equal workloads.

Emergency and General Medicine have larger encounter volumes, while several specialty departments have smaller but different utilization patterns.

### Encounter type

The proportion of ER, outpatient, inpatient, and observation encounters varies by department.

### Financial distribution

Claim/billing amounts are **right-skewed**, with most encounters having moderate values and a smaller number of high-value encounters.

### Operational metrics

Wait time and length of stay also contain realistic variation rather than being distributed into equal buckets.

This makes the dataset more suitable for:

- percentiles
- outlier analysis
- segmentation
- trend analysis
- SQL benchmarking
- Power BI storytelling

---

# Technology Stack

| Technology | Purpose |
|---|---|
| **SQL** | Data extraction, validation, joins, aggregations and analysis |
| **SQLite** | Relational healthcare database |
| **Python** | Cleaning, transformation and analytical exploration |
| **Pandas** | Data manipulation |
| **NumPy** | Numerical calculations |
| **Jupyter Notebook** | Reproducible analysis |
| **Power BI** | Interactive dashboards |
| **DAX** | Healthcare KPI calculations |

---

#  Project Structure

```text
innovaccer_project/
│
├── 01_data_raw/
│   ├── patients.csv
│   ├── encounters.csv
│   ├── physicians.csv
│   ├── departments.csv
│   ├── diagnosis_catalog.csv
│   ├── innovaccer_healthcare.db
│   └── README.txt
│
├── 02_sql/
│   ├── 00_schema.sql
│   ├── 01_quality_checks.sql
│   ├── 02_analysis_queries.sql
│   └── 03_views.sql
│
├── 03_python/
│   ├── analysis.py
│   ├── healthcare_patient_operations.ipynb
│   └── requirements.txt
│
├── 04_powerbi/
│   ├── measures.dax
│   └── POWER_BI_BUILD_GUIDE.md
│
├── 05_outputs/
│   ├── fact_encounters_enriched.csv
│   ├── patients_cleaned.csv
│   ├── encounters_cleaned.csv
│   ├── department_kpis.csv
│   ├── diagnosis_kpis.csv
│   ├── monthly_trends.csv
│   ├── provider_kpis.csv
│   ├── patient_utilization.csv
│   ├── anomalies.csv
│   ├── data_quality_summary.csv
│   └── overall_kpis.json
│
├── 06_docs/
│   ├── PROJECT_REPORT.md
│   ├── DATA_DICTIONARY.md
│   ├── INTERVIEW_QA.md
│   ├── RESUME_BULLETS.md
│   └── PORTFOLIO_CHECKLIST.md
│
├── 07_dashboard/
│   ├── dashboard.html
│   ├── 01_monthly_encounters.png
│   ├── 02_department_volume.png
│   ├── 03_department_wait_time.png
│   └── 04_billed_distribution.png
│
└── README.md
```

---

#  Data Quality & Validation

Before using the data for analysis, the project performs validation checks.

### Identifier validation

- Duplicate patient IDs
- Duplicate encounter IDs
- Duplicate provider IDs

### Missing-value validation

- Missing region
- Missing marital status
- Missing provider ID

### Financial validation

- Negative billed amount
- Paid amount greater than billed amount

### Operational validation

- Invalid wait-time values
- Invalid length-of-stay values
- Invalid dates

### Referential validation

Encounters are checked against:

- Patients
- Departments
- Physicians
- Diagnosis catalog

### Cleaning strategy

The raw data is preserved.

For reporting:

```text
Missing administrative value
            ↓
         "Unknown"
```

This prevents records from being silently dropped.

---

# SQL Analysis

The project uses SQL as the primary analytical layer.

The SQL workflow includes:

### Data extraction

Multi-table joins between:

```text
Patients
   +
Encounters
   +
Physicians
   +
Departments
   +
Diagnosis Catalog
```

### Analytical techniques

- `JOIN`
- `GROUP BY`
- `HAVING`
- `CASE`
- `CTE`
- Aggregations
- Window functions
- Trend analysis
- Ranking
- Exception detection

### Business analyses

The project analyzes:

**Patient Operations**
- Encounter volume
- Admissions
- Department workload
- Waiting time
- Length of stay

**Clinical Activity**
- Diagnosis volume
- Diagnosis trends
- Department-level diagnosis patterns

**Utilization**
- Unique patients
- Repeat patients
- High-utilizer patients
- Encounter frequency

**Financial**
- Total billed amount
- Total paid amount
- Collection rate
- Department-level billing

**Readmissions**
- 30-day readmission count
- Readmission rate
- Department-level readmission patterns

**Time Trends**
- Monthly encounter volume
- Monthly patient volume
- Monthly admissions
- Monthly billing activity

---

#  Python Analysis

Python is used after SQL extraction for flexible data preparation and analysis.

### Main steps

```text
Load data
   ↓
Convert data types
   ↓
Check missing values
   ↓
Clean administrative fields
   ↓
Join dimension data
   ↓
Create analytical features
   ↓
Analyze distributions
   ↓
Detect anomalies
   ↓
Export Power BI-ready data
```

### Derived fields

Examples include:

- Year
- Month
- Admission Flag
- Completion Flag
- Net Amount
- Patient utilization indicators

---

#  Anomaly Analysis

The project uses explainable statistical thresholds rather than a black-box model.

### High wait-time encounters

A record is flagged when waiting time exceeds the **95th percentile**.

Current portfolio threshold:

```text
124.0 minutes
```

### High billed amount

A record is flagged when billed amount exceeds the **99th percentile**.

Current portfolio threshold:

```text
$22,271.52
```

### Long inpatient length of stay

An inpatient encounter is flagged when LOS exceeds the inpatient **99th percentile**.

Current portfolio threshold:

```text
13.4 days
```

> These are analytical thresholds for the synthetic dataset. They are not clinical standards.

---

#  Key Portfolio Metrics

The current synthetic dataset produces the following portfolio-level values:

| KPI | Value |
|---|---:|
| Total Encounters | **25,370** |
| Unique Patients | **15,000** |
| Admissions | **8,168** |
| Average Wait Time | **51.3 min** |
| Average Inpatient LOS | **4.26 days** |
| 30-day Readmissions Flagged | **316** |
| Total Billed | **$80.33M** |
| Total Paid | **$58.87M** |
| Collection Rate | **73.3%** |

These numbers describe the synthetic portfolio and should not be presented as real healthcare statistics.

---

#  Power BI Dashboard

The dashboard is designed as a **3-page healthcare operations reporting solution**.

## Page 1 — Executive Overview

### KPI cards

- Total Encounters
- Unique Patients
- Admissions
- Average Wait Time
- 30-day Readmission Rate
- Total Billed

### Visuals

- Monthly encounter trend
- Department encounter volume
- Average wait by department
- Encounter type distribution
- Filters for:
  - Date
  - Department
  - Payer
  - Encounter Type

### Business question

> **What is happening across the organization?**

---

## Page 2 — Patient Flow & Utilization

### Analysis

- Admission trend
- Average LOS by department
- Repeat vs. single-visit patients
- High-utilizer patients
- Diagnosis volume
- Readmissions by department

### Business question

> **Where are patient-flow and utilization pressures occurring?**

---

## Page 3 — Data Quality & Anomalies

### Analysis

- Missing provider IDs
- Missing region
- Missing marital status
- High wait-time encounters
- High billed-amount encounters
- Long inpatient LOS

### Business question

> **Which records or operational patterns require further review?**

---

#  Power BI Data Model

The recommended model is a simple star-style design:

```text
                 Patients
                    │
                    │
Physicians ───── Encounters ───── Departments
                    │
                    │
              Diagnosis Catalog
                    │
                  Date
```

### Relationships

```text
Patients[Patient_ID]
        1
        │
        *
Encounters[Patient_ID]


Physicians[Provider_ID]
        1
        │
        *
Encounters[Provider_ID]


Departments[Department_ID]
        1
        │
        *
Encounters[Department_ID]


Diagnosis_Catalog[Diagnosis_Code]
        1
        │
        *
Encounters[Primary_Diagnosis_Code]


Date[Date]
        1
        │
        *
Encounters[Service_Date]
```

---

# Core DAX Measures

The Power BI package includes measures such as:

```DAX
Total Encounters

Unique Patients

Admissions

Avg Wait (Min)

Avg Inpatient LOS (Days)

30d Readmissions

30d Readmission Rate

Total Billed

Total Paid

Collection Rate

Average Billed / Encounter

Completed Encounters

No-Show Rate
```

---

