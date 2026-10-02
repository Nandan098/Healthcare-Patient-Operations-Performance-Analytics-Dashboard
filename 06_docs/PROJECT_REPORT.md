# Project Report — Healthcare Patient Operations Analytics

## 1. Business question
How can provider operations use patient encounter data to monitor demand, patient flow, utilization, financial activity, and potential operational anomalies?

## 2. Analytical approach
### Extract
Healthcare entities are loaded into a relational SQLite database.

### Clean & validate
Primary keys, missing administrative values, foreign keys, operational ranges, and financial consistency are checked.

### Analyze
SQL and Python are used to create department, monthly, diagnosis, provider, utilization, and anomaly outputs.

### Visualize
The Power BI layer uses KPI cards, trends, department comparisons, diagnosis analysis, and data-quality/anomaly pages.

## 3. Synthetic dataset design
The data intentionally avoids equal weighting. Patient visit frequency is skewed, department volumes differ, encounter type depends partly on department, and financial/wait-time distributions have long right tails. Small missing-data cases are included for realistic validation practice.

## 4. Key portfolio findings
Because the data are synthetic, findings should be discussed as examples of what the dashboard would surface rather than as real healthcare facts.

- Emergency and General Medicine have the largest encounter volumes in this dataset.
- Outpatient encounters are the largest encounter-type group.
- Billed amounts are right-skewed, so median and percentile metrics are more informative than assuming a normal distribution.
- A small subset of encounters are flagged for high wait time, high billed amount, or long inpatient LOS.
- Readmission flags are concentrated in a small subset of admission encounters.

## 5. Suggested business narrative
1. Start with overall demand and patient volume.
2. Drill down into department workload.
3. Examine wait time and length of stay to identify operational pressure points.
4. Review readmissions by department/diagnosis.
5. Separate normal activity from percentile-based anomalies.
6. Use data-quality checks before treating any dashboard result as decision-ready.

## 6. Interview explanation
“I treated the project like a real implementation analytics workflow. I preserved raw synthetic healthcare data, validated it in SQL, created a clean reporting layer, used Python for transformation and anomaly detection, then designed a Power BI semantic model with measures for operational KPIs. The dashboard lets stakeholders move from hospital-level KPIs into department, diagnosis, payer, and time-based analysis.”
