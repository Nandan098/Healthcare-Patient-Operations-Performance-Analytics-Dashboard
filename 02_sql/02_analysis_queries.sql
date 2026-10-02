-- 02_analysis_queries.sql
-- Business analysis queries for the Power BI-ready project.

-- KPI 1: overall operational summary
SELECT
    COUNT(*) AS total_encounters,
    COUNT(DISTINCT Patient_ID) AS unique_patients,
    SUM(CASE WHEN Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END) AS admissions,
    ROUND(AVG(Wait_Time_Minutes),1) AS avg_wait_minutes,
    ROUND(AVG(CASE WHEN Encounter_Type='Inpatient' THEN Length_of_Stay_Days END),2) AS avg_inpatient_los,
    SUM(Readmission_30d) AS readmissions_30d,
    ROUND(100.0*SUM(Readmission_30d) /
          NULLIF(SUM(CASE WHEN Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END),0),2) AS readmission_rate_pct,
    ROUND(SUM(Billed_Amount),2) AS total_billed,
    ROUND(SUM(Paid_Amount),2) AS total_paid,
    ROUND(100.0*SUM(Paid_Amount)/NULLIF(SUM(Billed_Amount),0),2) AS collection_rate_pct
FROM encounters;

-- KPI 2: department performance
SELECT
    d.Department_Name,
    d.Service_Line,
    COUNT(*) AS encounters,
    COUNT(DISTINCT e.Patient_ID) AS patients,
    SUM(CASE WHEN e.Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END) AS admissions,
    ROUND(AVG(e.Wait_Time_Minutes),1) AS avg_wait_minutes,
    ROUND(AVG(CASE WHEN e.Length_of_Stay_Days > 0 THEN e.Length_of_Stay_Days END),2) AS avg_los_days,
    SUM(e.Readmission_30d) AS readmissions_30d,
    ROUND(SUM(e.Billed_Amount),2) AS billed_amount
FROM encounters e
JOIN departments d ON e.Department_ID = d.Department_ID
GROUP BY d.Department_Name, d.Service_Line
ORDER BY encounters DESC;

-- KPI 3: monthly trend
SELECT
    substr(Service_Date,1,7) AS month,
    COUNT(*) AS encounters,
    COUNT(DISTINCT Patient_ID) AS unique_patients,
    SUM(CASE WHEN Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END) AS admissions,
    ROUND(AVG(Wait_Time_Minutes),1) AS avg_wait_minutes,
    ROUND(SUM(Billed_Amount),2) AS billed_amount
FROM encounters
GROUP BY substr(Service_Date,1,7)
ORDER BY month;

-- KPI 4: diagnosis trends
SELECT
    dc.Diagnosis_Name,
    COUNT(*) AS encounters,
    COUNT(DISTINCT e.Patient_ID) AS patients,
    SUM(CASE WHEN e.Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END) AS admissions,
    ROUND(AVG(e.Wait_Time_Minutes),1) AS avg_wait_minutes,
    ROUND(SUM(e.Billed_Amount),2) AS billed_amount
FROM encounters e
JOIN diagnosis_catalog dc
  ON e.Primary_Diagnosis_Code = dc.Diagnosis_Code
GROUP BY dc.Diagnosis_Name
ORDER BY encounters DESC;

-- KPI 5: high-utilization patients
WITH utilization AS (
    SELECT Patient_ID, COUNT(*) AS encounter_count,
           SUM(CASE WHEN Encounter_Type IN ('Inpatient','Observation') THEN 1 ELSE 0 END) AS admission_count
    FROM encounters
    GROUP BY Patient_ID
)
SELECT *
FROM utilization
WHERE encounter_count >= 4
ORDER BY encounter_count DESC, admission_count DESC;

-- KPI 6: anomaly review using percentile-like thresholds from SQLite's available functions.
-- For production SQL, use a proper percentile function/window strategy supported by your DBMS.
SELECT *
FROM encounters
WHERE Wait_Time_Minutes >= (SELECT MAX(Wait_Time_Minutes) FROM encounters WHERE Wait_Time_Minutes < 305)
   OR Billed_Amount >= 22000
ORDER BY Billed_Amount DESC;
