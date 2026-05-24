# \# Business Requirements Document (BRD)

# 

# \*\*Project Name:\*\* UHN Emergency Department Resource Capacity Analytics Platform  

# \*\*Target Enterprise:\*\* University Health Network (UHN), Toronto, ON  

# \*\*Author:\*\* Lead Healthcare Business Analyst  

# \*\*Framework Method:\*\* Agile (Scrum)  

# 

# \---

# 

# \## 1. Executive Summary \& Problem Statement

# The University Health Network (UHN) emergency departments have experienced an unprecedented 18% year-over-year surge in patient admission volume. Due to legacy data architectures, operational tracking relies on disjointed spreadsheets and manual logging. This lack of interconnected real-time visibility between triage check-ins, clinical staff scheduling, and physical bed occupancy has created severe system bottlenecks. 

# 

# Consequently, patient check-in-to-assessment wait times have increased by 35%, and annual nursing overtime expenditures have breached baseline operational budgets by 22%. This project introduces a modular, automated information system to ingest raw triage logs, calculate real-time asset utilization metrics, and reduce executive decision-making latency by 30%.

# 

# \---

# 

# \## 2. Project Scope \& Boundary Matrix

# 

# \### In-Scope (What We Are Engineering):

# \* Architectural blueprint of a normalized, transactional relational database schema (Star Schema) in MySQL.

# \* Automated data validation, type-casting, and feature engineering pipelines programmed in Python (Pandas \& NumPy).

# \* Parametric statistical modeling (Pearson r Correlation) to mathematically validate operational staffing floors.

# \* Interactive, filter-responsive executive control room dashboards deployed in Tableau Public.

# 

# \### Out-of-Scope (Future Enhancements):

# \* Real-time streaming integration with live Ontario electronic health record (EHR) feeds (e.g., Epic Systems).

# \* Predictive machine learning forecasting models for patient arrivals (allocated for Phase 2).

# \* Automated staff scheduling dispatch tools.

# 

# \---

# 

# \## 3. Formal Agile User Stories \& Acceptance Criteria

# 

# \### Epic 1: Clinical Resource Optimization \& Threshold Alerts

# \* \*\*User Story 1:\*\*

# &#x20; \* \*\*As an\*\* ER Lead Triage Nurse,

# &#x20; \* \*\*I want\*\* an automated monitoring interface for active patient check-ins,

# &#x20; \* \*\*So that\*\* I can instantly identify bottleneck thresholds when local wait latencies exceed the strict 60-minute threshold.

# &#x20; \* \*\*Acceptance Criteria:\*\* \* The analytical layer must dynamically compute wait time as the difference between `arrival\_timestamp` and `physician\_initial\_assessment\_timestamp`.

# &#x20;   \* Visual interfaces must flag records violating the 60-minute benchmark using explicit conditional color indicators.

# 

# \### Epic 2: Executive Decision Support \& Shift Planning

# \* \*\*User Story 2:\*\*

# &#x20; \* \*\*As the\*\* Chief Medical Officer (CMO),

# &#x20; \* \*\*I want\*\* a diagnostic visualization tracking weekly Bed Utilization Rates across individual units,

# &#x20; \* \*\*So that\*\* I can strategically reallocate staff scheduling shifts to match historical patient surge velocities.

# &#x20; \* \*\*Acceptance Criteria:\*\*

# &#x20;   \* Bed utilization must be programmatically formulated as: `(Actual Hours Occupied / Allocated Staffing Window Limit) \* 100`.

# &#x20;   \* The user interface must support automatic cross-filtering, allowing users to click an over-capacity unit cell and instantly view granular case logs.

# 

# \---

# 

# \## 4. Rigorous Business Rules \& Data Quality Guardrails

# 

# To ensure total system stability and clinical accuracy, the ingestion pipeline enforces the following strict operational logic gates:

# 

# | Rule ID | Data Element | Ingestion Rule | Failure Action |

# | :--- | :--- | :--- | :--- |

# | \*\*BR-001\*\* | `Arrival\_Time` | Must contain a valid ISO timestamp. Cannot be NULL or blank. | Reject transaction entirely; route row to `System Error Log`. |

# | \*\*BR-002\*\* | `Triage\_Acuity` | Must be an integer between 1 (Resuscitation) and 5 (Non-Urgent) following the Canadian Triage and Acuity Scale (CTAS). | Flag record as 'Incomplete Triage' and isolate for audit. |

# | \*\*BR-003\*\* | `Discharge\_Time` | If missing or NULL, the patient is classified as currently active in a physical bed. | Dynamic Imputation: Programmatically apply the active execution running snapshot timestamp. |

# | \*\*BR-004\*\* | `Bed\_Utilization\_Rate\_Pct` | Any value calculated strictly above 85.00% is classified as a critical system strain. | Trigger a conditional UI alert flag (`CRITICAL\_OVERFLOW\_RISK`). |

# 

# \---

# 

# \## 5. System Data Lineage

# The system's data pathway functions via four modular abstraction layers:

# 1\. \*\*Ingestion Layer:\*\* Raw comma-separated transaction payloads (`uhn\_raw\_triage\_logs.csv`) are fetched by the data engine.

# 2\. \*\*Transformation Layer (Python):\*\* Data cleaning rules handle type-casting, fill open records, and feature-engineer length of stay and utilization values.

# 3\. \*\*Storage Layer (MySQL):\*\* Clean records are structurally committed to a relational schema utilizing strict foreign key constraints.

# 4\. \*\*Presentation Layer (Tableau):\*\* Executive dashboard consumes data, enabling dynamic cross-filtering and root-cause analysis.

