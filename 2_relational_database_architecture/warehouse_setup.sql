-- ============================================================================
-- UNIVERSITY HEALTH NETWORK (UHN) CAPACITY ANALYTICS SCHEMA
-- PURPOSE: RELATIONAL ENGINE SCHEMA DESIGN WITH INTEGRITY CONSTRAINTS
-- ============================================================================

CREATE DATABASE IF NOT EXISTS UHN_Capacity_Analytics;
USE UHN_Capacity_Analytics;

-- 1. DIMENSION TABLE: PATIENT DIRECTORY
CREATE TABLE Dim_Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_mrn VARCHAR(50) NOT NULL UNIQUE,
    age INT NOT NULL,
    postal_code_prefix VARCHAR(3) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. DIMENSION TABLE: CLINICAL STAFF DIRECTORY
CREATE TABLE Dim_Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    staff_hash VARCHAR(64) NOT NULL UNIQUE,
    clinical_role VARCHAR(50) NOT NULL,
    department_assignment VARCHAR(50) NOT NULL,
    hourly_overtime_rate DECIMAL(10, 2) NOT NULL
);

-- 3. DIMENSION TABLE: PHYSICAL ASSETS (BED REGISTRY)
CREATE TABLE Dim_Beds (
    bed_id INT AUTO_INCREMENT PRIMARY KEY,
    bed_code VARCHAR(20) NOT NULL UNIQUE,
    unit_type VARCHAR(50) NOT NULL,
    is_isolation_equipped BOOLEAN DEFAULT FALSE
);

-- 4. CENTRAL TRANSACTIONAL ENGINE: ER ADMISSIONS FACT TABLE
CREATE TABLE Fact_ER_Admissions (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_uuid VARCHAR(64) NOT NULL UNIQUE,
    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    bed_id INT NOT NULL,
    triage_acuity_score INT NOT NULL, -- CTAS Scale (1: Critical to 5: Non-Urgent)
    arrival_timestamp DATETIME NOT NULL,
    triage_completed_timestamp DATETIME,
    physician_initial_assessment_timestamp DATETIME,
    discharge_timestamp DATETIME,
    wait_time_minutes INT GENERATED ALWAYS AS (
        TIMESTAMPDIFF(MINUTE, arrival_timestamp, physician_initial_assessment_timestamp)
    ) STORED,
    
    CONSTRAINT FK_Fact_Patients FOREIGN KEY (patient_id) REFERENCES Dim_Patients(patient_id),
    CONSTRAINT FK_Fact_Staff FOREIGN KEY (staff_id) REFERENCES Dim_Staff(staff_id),
    CONSTRAINT FK_Fact_Beds FOREIGN KEY (bed_id) REFERENCES Dim_Beds(bed_id)
);

-- INJECT MOCK PRODUCTION RECORDS FOR DOWNSTREAM ANALYSIS
INSERT INTO Dim_Patients (patient_mrn, age, postal_code_prefix) VALUES 
('MRN-9941', 45, 'M5G'), ('MRN-2310', 29, 'M5B'), ('MRN-8842', 62, 'M4X'),
('MRN-1102', 19, 'M5S'), ('MRN-5531', 73, 'M4Y'), ('MRN-7740', 35, 'M5V');

INSERT INTO Dim_Staff (staff_hash, clinical_role, department_assignment, hourly_overtime_rate) VALUES
('STF_H8271', 'MD', 'Emergency', 120.00), ('STF_H1102', 'RN', 'Emergency', 75.00),
('STF_H4491', 'RN', 'ICU', 75.00), ('STF_H5521', 'MD', 'ICU', 135.00);

INSERT INTO Dim_Beds (bed_code, unit_type, is_isolation_equipped) VALUES
('ER-BED-01', 'Emergency', FALSE), ('ER-BED-02', 'Emergency', TRUE),
('ICU-BED-05', 'ICU', TRUE), ('ICU-BED-12', 'ICU', FALSE), ('ER-BED-03', 'Emergency', FALSE);

INSERT INTO Fact_ER_Admissions (transaction_uuid, patient_id, staff_id, bed_id, triage_acuity_score, arrival_timestamp, physician_initial_assessment_timestamp, discharge_timestamp) VALUES
('UUID-A01', 1, 1, 1, 2, '2026-05-24 08:00:00', '2026-05-24 08:45:00', '2026-05-24 14:30:00'),
('UUID-A02', 2, 2, 4, 4, '2026-05-24 08:15:00', '2026-05-24 09:37:00', '2026-05-24 23:45:00'),
('UUID-A03', 3, 1, 2, 1, '2026-05-24 08:30:00', '2026-05-24 09:00:00', NULL),
('UUID-A04', 4, 2, 1, 3, '2026-05-24 09:00:00', '2026-05-24 10:55:00', '2026-05-24 11:15:00'),
('UUID-A05', 5, 1, 5, 2, '2026-05-24 09:15:00', '2026-05-24 09:50:00', '2026-05-24 19:00:00');