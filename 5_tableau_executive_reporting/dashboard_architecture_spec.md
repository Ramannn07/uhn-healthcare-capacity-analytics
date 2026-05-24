\# UHN Tableau Executive Control Room - Technical Design Specification



🔗 \*\*Live Interactive Dashboard Deployment:\*\* \[PASTE YOUR COPIED TABLEAU PUBLIC URL HERE]



This document details the functional metadata layer, visual hierarchy, and programmatic calculated fields deployed within the Tableau analytical dashboard interface.



\## 1. Visual Hierarchy \& Grid Mapping

The canvas layer is engineered using a clean modular layout grid prioritizing data scannability for high-stress medical triage monitoring:



```text

+------------------------------------------------------------------------------------+

| \[KPI CARD: Median Wait Time]  \[KPI CARD: Bed Occupancy %]  \[KPI CARD: Active Surges] |

+------------------------------------------------------------------------------------+

|                                                                                    |

| (Visual 1) Patient Flow Bottleneck Ingestion Timeline (Gantt Phase Tracking)        |

|                                                                                    |

+------------------------------------------------------------------------------------+

| (Visual 2) Cross-Unit Capacity Heatmap     | (Visual 3) Actual vs Target Staffing  |

|# UHN Tableau Executive Control Room - Technical Design Specification<br /><br />🔗 \*\*Live Interactive Dashboard Project Deployment:https://public.tableau.com/views/uhn\_capacity\_dashboard/Dashboard1?:language=en-US\&publish=yes\&:sid=\&:redirect=auth\&:display\_count=n\&:origin=viz\_share\_link|
|-|



