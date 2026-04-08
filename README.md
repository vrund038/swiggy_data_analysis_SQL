Here is your **GitHub-friendly README.md** formatted like the example you shared.
You can **copy directly into README.md**.

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

```sql
WITH CTE AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY state,order_date,city,restaurant_name,
location,category,dish_name,price_inr,rating,rating_count
) as rn
FROM swiggy_data
)
DELETE FROM CTE WHERE rn > 1;
```

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

# 🏗️ Fact Table

```sql
CREATE TABLE fact_swiggy_data (
order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
date_id INT,
price_inr DECIMAL(10,2),
rating DECIMAL(4,2),
rating_count INT,
location_id INT,
restaurant_id INT,
category_id INT,
dish_id INT
);
```

---

# 📈 Business Analysis Performed

# 💰 Total Revenue

```sql
SELECT 
ROUND(SUM(price_inr)/1000000.0,2) AS revenue_million
FROM fact_swiggy_data;
```

---

# 📅 Revenue by Day

```sql
SELECT 
TO_CHAR(d.full_date,'FMDay') AS day_name,
SUM(f.price_inr) AS revenue
FROM fact_swiggy_data f
JOIN dim_date d
ON f.date_id = d.date_id
GROUP BY day_name
ORDER BY revenue DESC;
```

---

# 🏆 Top Restaurants

```sql
SELECT 
r.restaurant_name,
SUM(f.price_inr) revenue
FROM fact_swiggy_data f
JOIN dim_restaurant r
ON f.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_name
ORDER BY revenue DESC;
```

---

# 🍽️ Top Selling Dishes

```sql
SELECT 
d.dish_name,
SUM(f.price_inr) revenue
FROM fact_swiggy_data f
JOIN dim_dish d
ON f.dish_id = d.dish_id
GROUP BY d.dish_name
ORDER BY revenue DESC;
```

---

# 📍 Revenue by City

```sql
SELECT 
l.city,
SUM(f.price_inr) revenue
FROM fact_swiggy_data f
JOIN dim_location l
ON f.location_id = l.location_id
GROUP BY l.city
ORDER BY revenue DESC;
```

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

---

This is now **GitHub-ready professional README**.
Your project now looks **portfolio-level professional** 🔥

---

If you'd like, I can also:

* Add screenshots section
* Add Power BI dashboard section
* Add architecture diagram
