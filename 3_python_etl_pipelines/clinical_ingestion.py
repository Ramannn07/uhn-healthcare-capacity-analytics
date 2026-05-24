"""
UNIVERSITY HEALTH NETWORK (UHN) - PRODUCTION INGESTION ENGINE
PURPOSE: GENERIC ETL PIPELINE FOR PROCESSING ADMISSION LOGS WITH TYPE-SAFE GUARDRAILS
"""

import os
import sys
import pandas as pd
import numpy as np

def execute_healthcare_etl(input_filename="uhn_raw_triage_logs.csv", output_filename="uhn_processed_capacity_data.csv"):
    """
    Ingests raw operational records from a CSV file, enforces strict clinical data 
    cleaning parameters, features engineering metrics, and exports clean reporting sets.
    """
    print(f"--- Starting UHN Extraction Layer for file: {input_filename} ---")
    
    # Verify file existence dynamically to prevent system crashes
    if not os.path.exists(input_filename):
        print(f"❌ CRITICAL ERROR: Target data file '{input_filename}' not found.")
        print("Please ensure the raw input CSV is placed in the active processing directory.")
        sys.exit(1)
        
    try:
        # Ingest independent dataset
        df = pd.read_csv(input_filename)
        initial_count = len(df)
        
        # 1. ENFORCE CLEANING & TYPE-CASTING GUARDRAILS
        # Drop records entirely missing crucial chronological identifiers
        df = df.dropna(subset=['Arrival_Time'])
        cleaned_count = len(df)
        if initial_count != cleaned_count:
            print(f"⚠️ DATA QUALITY ALERT: Dropped {initial_count - cleaned_count} rows due to null Arrival_Time records.")

        # Cast string columns into standardized ISO Datetime structures
        df['Arrival_Time'] = pd.to_datetime(df['Arrival_Time'], errors='coerce')
        df['Discharge_Time'] = pd.to_datetime(df['Discharge_Time'], errors='coerce')
        
        # Diagnostic Imputation: If patient is still active in a physical bed, use current snapshot time
        current_execution_snapshot = pd.Timestamp.now()
        df['Discharge_Time'] = df['Discharge_Time'].fillna(current_execution_snapshot)
        
        # 2. FEATURE ENGINEERING & METRIC LAYER
        # Calculate active length of stay in precise decimal hours
        df['Length_of_Stay_Hours'] = (df['Discharge_Time'] - df['Arrival_Time']).dt.total_seconds() / 3600
        df['Length_of_Stay_Hours'] = df['Length_of_Stay_Hours'].round(2)
        
        # Calculate key diagnostic asset efficiency: Bed Utilization Rate %
        # Formulated as: (Actual Hours Occupied / Allocated Theoretical Staffing Window Limit) * 100
        df['Bed_Utilization_Rate_Pct'] = (df['Length_of_Stay_Hours'] / df['Unit_Capacity_Limit_Hours']) * 100
        df['Bed_Utilization_Rate_Pct'] = df['Bed_Utilization_Rate_Pct'].round(2)
        
        # Operational Conditional Logic Flagging
        df['Capacity_Breach_Alert'] = np.where(df['Bed_Utilization_Rate_Pct'] > 85.00, 'CRITICAL_OVERFLOW_RISK', 'OPTIMAL_CAPACITY')
        
        # 3. EXPORT LOAD LAYER
        df.to_csv(output_filename, index=False)
        print(f"✅ SUCCESS: Formatted operational analytics matrix saved to: {output_filename}")
        print(df[['Patient_MRN', 'Bed_Code', 'Bed_Utilization_Rate_Pct', 'Capacity_Breach_Alert']].head())
        
    except Exception as error_msg:
        print(f"❌ PIPELINE EXECUTION FAILURE: {str(error_msg)}")

if __name__ == '__main__':
    # Execute the modular workflow script
    execute_healthcare_etl()