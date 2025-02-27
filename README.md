dbt_databricks_project
Overview
This dbt project transforms and models data for the US Softball League and Unity Golf Club, helping to clean up inconsistencies and create a unified dataset. The final tables support analytics and reporting needs.

What's Inside?
staging: Cleans raw data from both organizations
core: Standardizes member info and joins with reference tables
mart: Final models for reporting and metrics
Key Features
Incremental Loads: New data is added without rebuilding everything
State Standardization: Converts full state names to 2-letter codes
Data Quality Tests: Ensures no missing companies, duplicates, or weird date values

Next Steps
Add more validation checks
Optimize incremental logic
fix some weird edge cases like DOB test I haven't fixed yet 😅
