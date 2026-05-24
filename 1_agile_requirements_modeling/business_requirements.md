# Business Requirements Document (BRD) & Agile Framework

## 1. Project Background & Problem Statement
The University Health Network (UHN) has experienced an unprecedented 18% surge in emergency department admissions over the past three quarters. Due to a lack of interconnected data tracking between triage registration, clinical staffing availability, and physical bed assignments, patient wait times have spiked, and annual nurse overtime expenditures have exceeded the baseline budget by 22%. 

This framework transitions UHN from legacy spreadsheet logging to an automated, analytical data ecosystem.

## 2. Agile User Stories & Acceptance Criteria

### Epics: Clinical Resource Optimization & Bottleneck Visibility
* **User Story 1 (Operational Focus):**
  * *As an ER Lead Nurse,* I want a real-time tracking interface for patient check-ins, so that I can instantly identify bottleneck thresholds when wait times exceed 60 minutes.
  * *Acceptance Criteria:* The system must calculate a running wait-time metric utilizing the difference between arrival and assessment timestamps, automatically flagging records exceeding 60 minutes.
* **User Story 2 (Executive Strategic Focus):**
  * *As a Chief Medical Officer (CMO),* I want a diagnostic dashboard displaying weekly Bed Utilization Rates, so that I can strategically reallocate staff shifts to match historical patient surge patterns.
  * *Acceptance Criteria:* Data must refresh seamlessly, displaying aggregate bed occupancy metrics across multiple distinct units (ER, ICU, Acute Care).

## 3. Data Lineage & BPMN Process Architecture