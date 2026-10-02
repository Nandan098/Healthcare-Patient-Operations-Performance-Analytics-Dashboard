-- 03_views.sql
-- Clean semantic layer used by Python/Power BI.
-- Missing administrative values are mapped to 'Unknown' for reporting.

DROP VIEW IF EXISTS vw_encounters_enriched;
CREATE VIEW vw_encounters_enriched AS
SELECT
    e.Encounter_ID,
    e.Patient_ID,
    e.Service_Date,
    strftime('%Y', e.Service_Date) AS Service_Year,
    strftime('%Y-%m', e.Service_Date) AS Service_Month,
    e.Department_ID,
    d.Department_Name,
    d.Service_Line,
    COALESCE(e.Provider_ID, 'Unknown') AS Provider_ID,
    COALESCE(pv.Provider_Display_Name, 'Unknown') AS Provider_Display_Name,
    e.Encounter_Type,
    e.Encounter_Status,
    e.Primary_Diagnosis_Code,
    dc.Diagnosis_Name,
    e.Wait_Time_Minutes,
    e.Length_of_Stay_Days,
    e.Billed_Amount,
    e.Paid_Amount,
    e.Billed_Amount - e.Paid_Amount AS Net_Amount,
    e.Readmission_30d,
    p.Gender,
    p.Payer,
    COALESCE(NULLIF(p.Region,''), 'Unknown') AS Region,
    COALESCE(NULLIF(p.Marital_Status,''), 'Unknown') AS Marital_Status
FROM encounters e
JOIN patients p ON e.Patient_ID = p.Patient_ID
JOIN departments d ON e.Department_ID = d.Department_ID
LEFT JOIN physicians pv ON e.Provider_ID = pv.Provider_ID
JOIN diagnosis_catalog dc ON e.Primary_Diagnosis_Code = dc.Diagnosis_Code;
