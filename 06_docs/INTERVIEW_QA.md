# Innovaccer Interview Q&A

## Project questions
**Q1. Why did you choose this project?**
A: The role is healthcare implementation analytics, so I wanted an end-to-end provider-operations use case rather than a generic sales or e-commerce dashboard.

**Q2. Why SQL + Python + Power BI?**
A: SQL is used for relational extraction and aggregation, Python for flexible validation and analytical logic, and Power BI for stakeholder-facing reporting.

**Q3. How did you validate the data?**
A: I checked duplicate IDs, missing administrative fields, orphan foreign keys, invalid wait/LOS ranges, negative billed amounts, and cases where paid amount exceeded billed amount.

**Q4. Why isn't the data equally weighted?**
A: Equal weighting makes a demonstration dataset look artificial. I used non-uniform category frequencies, skewed visit frequency, seasonal variation, and long-tailed financial/wait distributions.

**Q5. What is an anomaly in your project?**
A: An anomaly is an encounter that falls beyond a portfolio-defined threshold, such as wait time above P95, billed amount above P99, or inpatient LOS above its P99. It is a review flag, not a clinical conclusion.

**Q6. How did you calculate readmission rate?**
A: 30-day readmission flags divided by admission encounters (Inpatient + Observation) for the selected filter context.

**Q7. What would you automate in a real company?**
A: Scheduled extraction, SQL validation checks, incremental transformations, refresh monitoring, and Power BI dataset refreshes.

**Q8. What are the key Power BI measures?**
A: Total Encounters, Unique Patients, Admissions, Avg Wait, Avg Inpatient LOS, 30d Readmissions, 30d Readmission Rate, Total Billed, Total Paid, and Collection Rate.

**Q9. What would you improve next?**
A: Add more encounter-level clinical/operational fields, build a proper date dimension, add drill-through pages, introduce row-level security for roles, and productionize the data-quality pipeline.

## Technical topics to revise
- SQL joins and CTEs
- Window functions
- GROUP BY / HAVING
- CASE expressions
- NULL handling
- Indexes
- Pandas merge/groupby
- Outlier detection: IQR / percentiles / z-score
- Power BI relationships and filter context
- DAX measures
- Dashboard storytelling
