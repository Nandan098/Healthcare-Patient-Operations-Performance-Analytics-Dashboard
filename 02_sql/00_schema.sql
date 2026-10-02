-- Innovaccer Healthcare Patient Operations Analytics
-- SQLite schema generated from the supplied synthetic dataset.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS departments (
    Department_ID TEXT PRIMARY KEY,
    Department_Name TEXT NOT NULL,
    Service_Line TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS physicians (
    Provider_ID TEXT PRIMARY KEY,
    Provider_Display_Name TEXT NOT NULL,
    Department_ID TEXT NOT NULL,
    Specialty TEXT NOT NULL,
    FOREIGN KEY (Department_ID) REFERENCES departments(Department_ID)
);

CREATE TABLE IF NOT EXISTS diagnosis_catalog (
    Diagnosis_Code TEXT PRIMARY KEY,
    Diagnosis_Name TEXT NOT NULL,
    Typical_Service_Line TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS patients (
    Patient_ID TEXT PRIMARY KEY,
    Birth_Date TEXT NOT NULL,
    Gender TEXT NOT NULL,
    Marital_Status TEXT,
    Payer TEXT NOT NULL,
    Region TEXT
);

CREATE TABLE IF NOT EXISTS encounters (
    Encounter_ID TEXT PRIMARY KEY,
    Patient_ID TEXT NOT NULL,
    Service_Date TEXT NOT NULL,
    Department_ID TEXT NOT NULL,
    Provider_ID TEXT,
    Encounter_Type TEXT NOT NULL,
    Encounter_Status TEXT NOT NULL,
    Primary_Diagnosis_Code TEXT NOT NULL,
    Wait_Time_Minutes INTEGER NOT NULL,
    Length_of_Stay_Days REAL NOT NULL,
    Billed_Amount REAL NOT NULL,
    Paid_Amount REAL NOT NULL,
    Readmission_30d INTEGER NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES patients(Patient_ID),
    FOREIGN KEY (Department_ID) REFERENCES departments(Department_ID),
    FOREIGN KEY (Provider_ID) REFERENCES physicians(Provider_ID),
    FOREIGN KEY (Primary_Diagnosis_Code) REFERENCES diagnosis_catalog(Diagnosis_Code)
);

CREATE INDEX IF NOT EXISTS idx_enc_patient ON encounters(Patient_ID);
CREATE INDEX IF NOT EXISTS idx_enc_date ON encounters(Service_Date);
CREATE INDEX IF NOT EXISTS idx_enc_dept ON encounters(Department_ID);
