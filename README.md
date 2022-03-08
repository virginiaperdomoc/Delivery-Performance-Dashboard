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

### Conclusions

● The main goal of this project is to identify which suppliers deliver our orders on the promised day or before, and which suppliers make late deliveries. To identify them, we calculated the on-time delivery rate of our suppliers.

● As a company, it is necessary to identify those vendors who consistently fail to deliver our orders in a timely manner, as these delays pose a reputational risk and negatively impact our operation.

● To be considered acceptable, the rate of on-time deliveries should be 95 percent or higher. The highest OTD rate was in the year 2020, reaching around 78%. This is evidence that we have serious issues with the delivery of our orders that urgently need to be addressed.

● In an effort to pinpoint which suppliers we should consider replacing, we identified our top 5 and bottom 5 vendors.


## Legal Terms

All data has been used for educational purpose only.