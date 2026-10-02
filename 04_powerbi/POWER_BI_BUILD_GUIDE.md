# Power BI Build Guide

## Recommended model
Use a simple star-style model:

- Fact: `Encounters`
- Dimension: `Patients`
- Dimension: `Physicians`
- Dimension: `Departments`
- Dimension: `Diagnosis_Catalog`
- Date: create a dedicated `Date` table

### Relationships
`Patients[Patient_ID] 1:* Encounters[Patient_ID]`
`Physicians[Provider_ID] 1:* Encounters[Provider_ID]`
`Departments[Department_ID] 1:* Encounters[Department_ID]`
`Diagnosis_Catalog[Diagnosis_Code] 1:* Encounters[Primary_Diagnosis_Code]`
`Date[Date] 1:* Encounters[Service_Date]`

## Dashboard Page 1 — Executive Overview
Top KPI cards:
1. Total Encounters
2. Unique Patients
3. Admissions
4. Avg Wait (Min)
5. 30d Readmission Rate
6. Total Billed

Charts:
- Line: Encounters by month
- Column: Encounters by department
- Bar: Avg Wait by department
- Donut: Encounter Type
- Slicer: Date, Department, Payer, Encounter Type

## Dashboard Page 2 — Patient Flow & Utilization
- Admissions trend
- Avg LOS by department
- Repeat vs single-visit patients
- High-utilizer patient count
- Diagnosis volume
- Readmissions by department

## Dashboard Page 3 — Data Quality & Anomalies
- Missing Provider ID
- Missing Region
- Missing Marital Status
- High Wait-Time encounters
- High Billed-Amount encounters
- Long Inpatient LOS encounters

## Storytelling
For every chart, answer:
- What happened?
- Where did it happen?
- When did it happen?
- What should operations investigate next?

Do not claim these synthetic results represent a real healthcare provider.
