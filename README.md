

---

# 🍔 Swiggy Data Analytics — SQL Data Warehouse Project

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?logo=postgresql\&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-025E8C?logo=postgresql\&logoColor=white)
![Data Warehouse](https://img.shields.io/badge/Data%20Warehouse-Star%20Schema-blue)
![Analytics](https://img.shields.io/badge/Data%20Analytics-SQL-green)
![Git](https://img.shields.io/badge/Git-Version%20Control-orange)

---

# 📌 Project Overview

This project focuses on **Swiggy Food Delivery Data Analysis** using **PostgreSQL** and **Data Warehouse Modeling**.

A **Star Schema Data Warehouse** was built to analyze:

* Revenue Trends
* Top Restaurants
* Popular Dishes
* City-wise Performance
* Day-wise Revenue

This project demonstrates **end-to-end SQL Data Analytics workflow**.

---

# 🏗️ Data Warehouse Architecture

```
              dim_date
                 |
dim_location — fact_swiggy_data — dim_restaurant
                 |
            dim_category
                 |
              dim_dish
```

---

# ⚡ Tech Stack

* PostgreSQL
* SQL
* pgAdmin
* Data Warehouse Modeling
* Star Schema
* Git & GitHub

---

# 📂 Dataset Information

The dataset includes:

* State
* City
* Order Date
* Restaurant Name
* Location
* Category
* Dish Name
* Price
* Rating
* Rating Count

---

# 🔄 Data Processing Steps

## 1️⃣ Data Cleaning

* Removed duplicate records
* Fixed data types
* Converted date formats
* Handled null values


---

# 🧱 Data Warehouse Tables

## Dimension Tables

* dim_date
* dim_location
* dim_restaurant
* dim_category
* dim_dish

## Fact Table

* fact_swiggy_data


---


# 📊 Key Insights

* Identified top performing cities
* Found highest revenue restaurants
* Determined popular dishes
* Analyzed day-wise revenue
* Built data warehouse for analytics

---

# 📂 Project Structure

```
Swiggy-Data-Analytics/
│
├── Dataset/
│   └── swiggy_data.csv
│
├── SQL/
│   ├── create_tables.sql
│   ├── insert_queries.sql
│   ├── analysis_queries.sql
│
├── README.md
```

---

# 🎯 Project Goals

* Practice SQL Data Analysis
* Build Data Warehouse
* Create Portfolio Project
* Generate Business Insights

---

# 🚀 Future Improvements

* Power BI Dashboard
* Advanced SQL Analytics
* Time Intelligence Analysis
* Performance Optimization

---

# 👨‍💻 Author

**Vrund Patel**
Aspiring Data Analyst
SQL | Power BI | Data Analytics

---

# ⭐ If you like this project

Give it a ⭐ on GitHub
