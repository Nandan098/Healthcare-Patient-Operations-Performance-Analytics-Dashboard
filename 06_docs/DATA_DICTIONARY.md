# Data Dictionary

## patients
| Column | Description |
|---|---|
| Patient_ID | Synthetic unique patient identifier |
| Birth_Date | Synthetic birth date |
| Gender | Synthetic gender category |
| Marital_Status | Synthetic marital-status category; a small number are missing in raw data |
| Payer | Synthetic primary payer category |
| Region | Synthetic region; a small number are missing in raw data |

## encounters
| Column | Description |
|---|---|
| Encounter_ID | Synthetic unique encounter ID |
| Patient_ID | Foreign key to patients |
| Service_Date | Encounter date |
| Department_ID | Foreign key to departments |
| Provider_ID | Foreign key to physicians; some missing in raw data |
| Encounter_Type | ER, Outpatient, Inpatient, or Observation |
| Encounter_Status | Completed, No-show, or Cancelled |
| Primary_Diagnosis_Code | Foreign key to diagnosis catalog |
| Wait_Time_Minutes | Operational waiting time |
| Length_of_Stay_Days | Length of stay; 0 for non-admission encounters |
| Billed_Amount | Synthetic billed amount |
| Paid_Amount | Synthetic paid amount |
| Readmission_30d | Synthetic indicator for a flagged 30-day readmission |

## physicians
Provider dimension used for department/provider-level analysis.

## departments
Department dimension with service line grouping.

## diagnosis_catalog
Diagnosis code and label reference table.

## Cleaning rules
- Preserve raw files unchanged.
- Map missing Region and Marital_Status to `Unknown` in reporting tables.
- Map missing Provider_ID to `Unknown`.
- Validate primary keys, foreign keys, numeric ranges, and billed-vs-paid logic.
