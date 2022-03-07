# Delivery Vendor Performance in Germany Dashboard

## Summary

The main goal of this project is to identify which suppliers are timely and which are tardy. The inclusion of other KPIs is welcomed. For this, we were supplied with an export from the Microsoft Dynamics NAV enterprise resource planning system that include the deliveries' information from December 2019 to March 2022.

In this project, we use the following methods:
● We carry out the data wrangling with Python, especifically with the NumPy and pandas libraries  
● To better understand the data, we perform some exploratory analysis in MySQL Workbench  
● The visualisations and dashboard were created using Tableau Public.  

---

## Data wrangling

During the wrangling process, we identified that some features that would enrich our analysis were missing. For example, in order to produce a map illustrating the deliveries, the latitudes and longitudes were necessary.

For a step-by-step overview of the data wrangling process, please refer to the corresponding Jupyter notebook, where you will find the code and comments. We will only include the final csv file with the clean data, not the original dataset.
  
## Additional data sources

The German postcodes dataset was downloaded from [Zauberware's GitHub](https://github.com/zauberware/postal-codes-json-xml-csv/blob/master/data/DE.zip).

## MySQL Workbench

After the wrangling process, the clean data was subsequently uploaded to MySQL Workbench for further analysis. To achieve this, we used [SQLAlchemy](https://www.sqlalchemy.org/), an open-source SQL toolkit and object-relational mapper.

## Visualization

All the results from the SQL analysis are presented in visualizations and a dashboard. They were created using [Tableau Public](https://public.tableau.com/).

### Dashboard 'Delivery Vendor Performance in Germany'

[Germany Delivery Vendor Performance Dashboard](https://public.tableau.com/app/profile/virginia.perdomo.cordero/viz/GermanyDeliveryVendorPerformanceDashboard/Dashboard1)

 ![Germany Delivery Vendor Performance Dashboard](/dashboard.png)

## Legal Terms

All data has been used for educational purpose only.