# Innovaccer — Healthcare Patient Operations & Performance Analytics

## Project objective
Build an end-to-end Data Analyst project for a healthcare provider setting. The project demonstrates:
- SQL database and analytical querying
- Python cleaning and validation
- Trend and anomaly analysis
- Power BI-ready semantic model and measures
- Business storytelling

This is aligned to the uploaded Innovaccer JD, which emphasizes the complete analysis lifecycle, cross-functional requirements, healthcare trends/anomalies, data quality, automation, SQL, visualization, and healthcare-data understanding.

## Dataset
The dataset supplied for this project is synthetic and intentionally non-uniform:
- 15,000 patients
- 25,370 encounters
- 170 providers
- 10 departments
- 15 diagnosis categories
- Study period: 2024-01-01 to 2026-09-30

The raw data is kept unchanged in `01_data_raw/`.

## Folder structure
```
innovaccer_project/
├── 01_data_raw/
├── 02_sql/
├── 03_python/
├── 04_powerbi/
├── 05_outputs/
├── 06_docs/
└── 07_dashboard/
```

## Run order
### 1. SQL
Open `01_data_raw/innovaccer_healthcare.db` in SQLite, DBeaver, or another SQL client.
Run:
1. `02_sql/01_quality_checks.sql`
2. `02_sql/03_views.sql`
3. `02_sql/02_analysis_queries.sql`

### 2. Python
Install:
```
pip install -r 03_python/requirements.txt
```
Run:
```
python 03_python/analysis.py
```
Or open `03_python/healthcare_patient_operations.ipynb`.

### 3. Power BI
Import `05_outputs/fact_encounters_enriched.csv` once generated, or connect Power BI directly to the SQLite database.
Follow `04_powerbi/POWER_BI_BUILD_GUIDE.md` and use `04_powerbi/measures.dax`.

## Current synthetic portfolio metrics
- Total encounters: 25,370
- Unique patients: 15,000
- Admissions (Inpatient + Observation): 8,168
- Average wait: 51.3 minutes
- Average inpatient LOS: 4.26 days
- 30-day readmissions flagged: 316
- Total billed: $80,332,721.05
- Total paid: $58,874,389.41
- Collection rate: 73.3%

## Anomaly thresholds used in the analysis
- High wait time: above the 95th percentile (124.0 min)
- High billed amount: above the 99th percentile ($22,271.52)
- Long inpatient LOS: above the inpatient 99th percentile (13.4 days)

These thresholds are analytical rules for this portfolio dataset, not clinical standards.

## Project limitations
- Data is synthetic; it does not represent any real organization or population.
- No clinical recommendation should be inferred from these records.
- The project demonstrates analytical workflow and dashboarding, not medical decision-making.
- A native Power BI `.pbix` file is not included; the package includes Power BI-ready data, DAX measures, model relationships, and a build guide.
