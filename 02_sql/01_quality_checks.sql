-- 01_quality_checks.sql
-- Run these before analysis. They are designed to demonstrate data validation.

-- 1. Duplicate primary keys
SELECT Patient_ID, COUNT(*) AS row_count
FROM patients
GROUP BY Patient_ID
HAVING COUNT(*) > 1;

SELECT Encounter_ID, COUNT(*) AS row_count
FROM encounters
GROUP BY Encounter_ID
HAVING COUNT(*) > 1;

-- 2. Missing administrative fields
SELECT COUNT(*) AS missing_region
FROM patients
WHERE Region IS NULL OR TRIM(Region) = '';

SELECT COUNT(*) AS missing_marital_status
FROM patients
WHERE Marital_Status IS NULL OR TRIM(Marital_Status) = '';

SELECT COUNT(*) AS missing_provider
FROM encounters
WHERE Provider_ID IS NULL OR TRIM(Provider_ID) = '';

-- 3. Invalid financial logic
SELECT COUNT(*) AS negative_billed_amount
FROM encounters
WHERE Billed_Amount < 0;

SELECT COUNT(*) AS paid_gt_billed
FROM encounters
WHERE Paid_Amount > Billed_Amount;

-- 4. Invalid operational ranges
SELECT COUNT(*) AS invalid_wait_time
FROM encounters
WHERE Wait_Time_Minutes < 0 OR Wait_Time_Minutes > 1440;

SELECT COUNT(*) AS invalid_los
FROM encounters
WHERE Length_of_Stay_Days < 0;

-- 5. Referential integrity spot checks
SELECT COUNT(*) AS orphan_patients
FROM encounters e
LEFT JOIN patients p ON e.Patient_ID = p.Patient_ID
WHERE p.Patient_ID IS NULL;

SELECT COUNT(*) AS orphan_departments
FROM encounters e
LEFT JOIN departments d ON e.Department_ID = d.Department_ID
WHERE d.Department_ID IS NULL;
