"""
Innovaccer Healthcare Patient Operations Analytics
Run:
    python analysis.py
Inputs:
    ../01_data_raw/innovaccer_healthcare.db
Outputs:
    ../05_outputs/*.csv, overall_kpis.json
"""
from pathlib import Path
import sqlite3
import pandas as pd
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / "01_data_raw" / "innovaccer_healthcare.db"
OUT = ROOT / "05_outputs"
OUT.mkdir(exist_ok=True)

conn = sqlite3.connect(DB)
patients = pd.read_sql_query("SELECT * FROM patients", conn)
encounters = pd.read_sql_query("SELECT * FROM encounters", conn)
departments = pd.read_sql_query("SELECT * FROM departments", conn)
diagnosis = pd.read_sql_query("SELECT * FROM diagnosis_catalog", conn)
conn.close()

encounters["Service_Date"] = pd.to_datetime(encounters["Service_Date"])
for c in ["Wait_Time_Minutes","Length_of_Stay_Days","Billed_Amount","Paid_Amount","Readmission_30d"]:
    encounters[c] = pd.to_numeric(encounters[c], errors="coerce")

# Cleaning / validation
patients["Marital_Status"] = patients["Marital_Status"].fillna("").replace("", "Unknown")
patients["Region"] = patients["Region"].fillna("").replace("", "Unknown")
encounters["Provider_ID"] = encounters["Provider_ID"].fillna("").replace("", "Unknown")

df = (encounters
      .merge(departments, on="Department_ID", how="left")
      .merge(patients[["Patient_ID","Gender","Payer","Region","Marital_Status"]], on="Patient_ID", how="left")
      .merge(diagnosis[["Diagnosis_Code","Diagnosis_Name"]], left_on="Primary_Diagnosis_Code", right_on="Diagnosis_Code", how="left"))

df["Is_Admission"] = df["Encounter_Type"].isin(["Inpatient","Observation"]).astype(int)
df["Is_Completed"] = (df["Encounter_Status"]=="Completed").astype(int)
df["Net_Amount"] = df["Billed_Amount"] - df["Paid_Amount"]
df["Month"] = df["Service_Date"].dt.to_period("M").astype(str)

monthly = df.groupby("Month", as_index=False).agg(
    Encounters=("Encounter_ID","count"),
    Unique_Patients=("Patient_ID","nunique"),
    Admissions=("Is_Admission","sum"),
    Avg_Wait_Minutes=("Wait_Time_Minutes","mean"),
    Billed_Amount=("Billed_Amount","sum"),
    Paid_Amount=("Paid_Amount","sum"),
)
monthly["Collection_Rate"] = monthly["Paid_Amount"] / monthly["Billed_Amount"]
monthly.to_csv(OUT/"monthly_trends.csv", index=False)

department = df.groupby(["Department_ID","Department_Name","Service_Line"], as_index=False).agg(
    Encounters=("Encounter_ID","count"),
    Patients=("Patient_ID","nunique"),
    Admissions=("Is_Admission","sum"),
    Avg_Wait_Minutes=("Wait_Time_Minutes","mean"),
    Avg_LOS_Days=("Length_of_Stay_Days", lambda s: s[s>0].mean() if (s>0).any() else 0),
    Readmissions_30d=("Readmission_30d","sum"),
    Billed_Amount=("Billed_Amount","sum"),
    Paid_Amount=("Paid_Amount","sum"),
)
department["Readmission_Rate"] = department["Readmissions_30d"] / department["Admissions"].replace(0,np.nan)
department.to_csv(OUT/"department_kpis.csv", index=False)

# Anomaly thresholds
wait_p95 = df["Wait_Time_Minutes"].quantile(0.95)
bill_p99 = df["Billed_Amount"].quantile(0.99)
inpt_p99 = df.loc[df["Encounter_Type"]=="Inpatient","Length_of_Stay_Days"].quantile(0.99)

anomalies = df[
    (df["Wait_Time_Minutes"] > wait_p95) |
    (df["Billed_Amount"] > bill_p99) |
    ((df["Encounter_Type"]=="Inpatient") & (df["Length_of_Stay_Days"] > inpt_p99))
]
anomalies.to_csv(OUT/"anomalies.csv", index=False)

print("Completed. Output:", OUT)
