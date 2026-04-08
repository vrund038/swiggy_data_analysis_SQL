# Swiggy Data Analytics — SQL Data Warehouse Project

## 📌 Project Overview
This project focuses on analyzing Swiggy food delivery data using PostgreSQL.
A Data Warehouse (Star Schema) approach was implemented to perform business analytics and insights.

##🏗️ Data Warehouse Architecture
This project follows Star Schema Model

**Fact Table**
1.fact_swiggy_data
**Dimension Tables**
1.dim_date
2.dim_location
3.dim_restaurant
4.dim_category
5.dim_dish

##📊 Database Schema
           dim_date
              |
dim_location — fact_swiggy_data — dim_restaurant
              |
         dim_category
              |
           dim_dish

##⚙️ Technologies Used
1.PostgreSQL
2.SQL
3.pgAdmin
4.Data Warehouse Modeling
5.Star Schema

##🔄 Data Processing Steps
-Removed duplicates using CTE + ROW_NUMBER()
-Converted data types
-Handled null values

##Created Dimension Tables
-dim_date
-dim_location
-dim_restaurant
-dim_category
-dim_dish

##Created Fact Table

##📊 Key Insights
-Identified top revenue generating cities
-Found best performing restaurants
-Analyzed popular food categories
-Determined peak order days
-Revenue trend analysis

##🎯 Project Goals
-Practice Data Warehouse Design
-Perform SQL Data Analysis
-Build Portfolio Project
-Understand Business Insights

##👨‍💻 Author

-Vrund Patel
-Aspiring Data Analyst | SQL | Power BI | Data Analytics
