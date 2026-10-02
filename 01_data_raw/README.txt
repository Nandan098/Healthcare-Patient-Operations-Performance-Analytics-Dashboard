INNOVACCER HEALTHCARE PATIENT OPERATIONS DATASET
Synthetic, reproducible, non-uniform dataset for portfolio/interview use.

STUDY PERIOD
2024-01-01 to 2026-09-30

VOLUME
Patients: 15,000
Encounters: 25,370

IMPORTANT DESIGN CHOICES
- Category frequencies are intentionally non-uniform; this is not an equal-weight demo dataset.
- Patient visit frequency is skewed: most patients have one encounter, while a smaller share returns repeatedly.
- Age distribution is skewed toward older adults to make provider-care utilization more realistic.
- Department volumes are uneven, and encounter types are correlated with department.
- Wait times and billed amounts have right-skewed distributions rather than equal-sized buckets.
- A small amount of missing administrative data is intentionally included for validation/cleaning practice.
- No real names, contact details, exact addresses, or real clinical records are included.
- Gender is not used as an arbitrary driver of cost, waiting time, or readmission; operational context and age/comorbidity proxies drive those variables.

PATIENT MIX
Gender | Female: 7,701 (51.34%)
Gender | Male: 7,203 (48.02%)
Gender | Other: 96 (0.64%)

PAYER MIX
Payer | Medicare: 5,068 (33.79%)
Payer | Commercial: 4,176 (27.84%)
Payer | Medicaid: 2,842 (18.95%)
Payer | Medicare Advantage: 1,574 (10.49%)
Payer | Self-Pay: 921 (6.14%)
Payer | Other: 419 (2.79%)

ENCOUNTER MIX
Encounter Type | Outpatient: 10,469 (41.27%)
Encounter Type | ER: 6,733 (26.54%)
Encounter Type | Inpatient: 6,070 (23.93%)
Encounter Type | Observation: 2,098 (8.27%)

DEPARTMENT MIX
Department | Emergency: 6,923 (27.29%)
Department | General Medicine: 5,122 (20.19%)
Department | Cardiology: 2,465 (9.72%)
Department | Orthopedics: 2,308 (9.1%)
Department | Oncology: 1,712 (6.75%)
Department | Pediatrics: 1,551 (6.11%)
Department | Obstetrics: 1,220 (4.81%)
Department | Neurology: 1,235 (4.87%)
Department | Surgery: 1,533 (6.04%)
Department | Other: 1,301 (5.13%)

OUTCOMES / STATUS
Status | Completed: 24,404 (96.19%)
Status | No-show: 549 (2.16%)
Status | Cancelled: 417 (1.64%)
30-day readmission flagged: 316 (1.25%)