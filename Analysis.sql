DROP TABLE IF EXISTS public.swiggy_data;

CREATE TABLE public.swiggy_data (
    state TEXT,
    city TEXT,
    order_date TEXT,
    restaurant_name TEXT,
    location TEXT,
    category TEXT,
    dish_name TEXT,
    price_inr NUMERIC,
    rating NUMERIC,
    rating_count INT
);


select count(*) from swiggy_data;


ALTER TABLE swiggy_data 
ALTER COLUMN order_date TYPE DATE 
USING TO_DATE(order_date, 'DD-MM-YYYY');


-- Data Validation and cleaning

-- Null Check


select 
	sum(case when state is null then 1 else 0 end) as null_state,
	sum(case when city is null then 1 else 0 end) as null_city,
	sum(case when order_date is null then 1 else 0 end) as null_order_date,
	sum(case when restaurant_name is null then 1 else 0 end) as null_restaurant_name,
	sum(case when location is null then 1 else 0 end) as null_location,
	sum(case when category is null then 1 else 0 end) as null_category,
	sum(case when dish_name is null then 1 else 0 end) as null_dish_name,
	sum(case when price_inr is null then 1 else 0 end) as null_price_inr,
	sum(case when rating is null then 1 else 0 end) as null_rating,
	sum(case when rating_count is null then 1 else 0 end) as null_rating_count
from swiggy_data;

-- there's no null value in data




--Blank or Empty Strings


select *
from swiggy_data
where state = '' or city ='' or restaurant_name = '' or location ='' or category ='' or dish_name = '';



-- Duplicate detection

select 
	state,order_date,city,restaurant_name,location,category,dish_name,price_inr,rating,rating_count,
    count(*) as CNT 
from swiggy_data
group by 
 state,
 order_date,
 city,
 restaurant_name,
 location,
 category,
 dish_name,
 price_inr,
 rating,
 rating_count
having count(*) > 1; 


-- Delete Duplication

with CTE as (
select *, ROW_NUMBER() OVER(
PARTITION BY state,order_date,city,restaurant_name,
location,category,dish_name,price_inr,rating,rating_count
order by (select null)
) as rn
from swiggy_data
)
delete from CTE where rn > 1;





-- Create Schema 


-- dim date 

CREATE TABLE dim_date(
    date_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    month_name VARCHAR(20),
    quarter INT,
    day INT,
    week INT
);



create table dim_location(
	location_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	state varchar(100),
	city varchar,
	location varchar
);



create table dim_restaurant(
	restaurant_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	restaurant_name varchar(100)
);



create table dim_category (
	category_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	category varchar(100)
);



create table dim_dish(
	dish_id  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	dish_name varchar(200)
);



--alter table dim_dish 
--alter column dish_name type varchar(200);

-- create fact table

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

ALTER TABLE fact_swiggy_data
ADD CONSTRAINT fk_date 
FOREIGN KEY (date_id) REFERENCES dim_date(date_id);

ALTER TABLE fact_swiggy_data
ADD CONSTRAINT fk_location 
FOREIGN KEY (location_id) REFERENCES dim_location(location_id);

ALTER TABLE fact_swiggy_data
ADD CONSTRAINT fk_restaurant 
FOREIGN KEY (restaurant_id) REFERENCES dim_restaurant(restaurant_id);

ALTER TABLE fact_swiggy_data
ADD CONSTRAINT fk_category 
FOREIGN KEY (category_id) REFERENCES dim_category(category_id);

ALTER TABLE fact_swiggy_data
ADD CONSTRAINT fk_dish 
FOREIGN KEY (dish_id) REFERENCES dim_dish(dish_id);


select * from fact_swiggy_data;





-- Insert data into table 

INSERT INTO dim_date 
(full_date, year, month, month_name, quarter, day, week)
SELECT DISTINCT
    order_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    TO_CHAR(order_date, 'Month') AS month_name,
    EXTRACT(QUARTER FROM order_date) AS quarter,
    EXTRACT(DAY FROM order_date) AS day,
    EXTRACT(WEEK FROM order_date) AS week
FROM swiggy_data
WHERE order_date IS NOT NULL;




insert into dim_location 
(state, city, location)
select distinct
	state,
	city,
	location
from swiggy_data;




insert into dim_restaurant(restaurant_name)
select distinct
	restaurant_name
from swiggy_data;



insert into dim_category(category)
select distinct
	category
from swiggy_data;


insert into dim_dish(dish_name)
select distinct
	dish_name
from swiggy_data;

-- select * from dim_dish limit 10;



insert into fact_swiggy_data
(
    date_id ,
    price_inr ,
    rating ,
    rating_count ,
    location_id ,
    restaurant_id ,
    category_id,
    dish_id 
)
select 
	dd.date_id,
	s.price_inr,
	s.rating,
	s.rating_count,
	dl.location_id,
	dr.restaurant_id,
	dc.category_id,
	dsh.dish_id
from swiggy_data s

join dim_date dd
	on dd.full_date = s.order_date

join dim_location dl
	on dl.state = s.state
	and dl.city = s.city
	and dl.location = s.location

join dim_restaurant dr
	on dr.restaurant_name = s.restaurant_name

join dim_category dc
	on dc.category = s.category

join dim_dish dsh
	on dsh.dish_name = s.dish_name;


select * from fact_swiggy_data limit 10;



select * from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
join dim_location l on f.location_id = l.location_id
join dim_restaurant r on f.restaurant_id = r.restaurant_id
join dim_category c on f.category_id = c.category_id
join dim_dish di on f.dish_id = di.dish_id;







-- KPI's 

-- Total Orders
select count(*) as Total_Order
from fact_swiggy_data;

-- 197430



-- Total Revenue

select 
	round(sum(price_inr)/1000000.0 ,2) || ' Million INR' as Total_revenue
from fact_swiggy_data;


-- Average Dish Price
select
	round(avg(price_inr),2) || 'INR' as Average_Price
from fact_swiggy_data;


--Average Rating

select 
	round(avg(rating),2) as Average_rating
from fact_swiggy_data;





-- Deep Drive Business Analysis


-- Monthly Order Trends 
select 
	d.year,
	d.month,
	d.month_name,
	count(*) as Total_orders
from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
group by month_name,year,month
order by Total_orders desc;


select 
	d.year,
	d.month,
	d.month_name,
	round(sum(price_inr)/1000000.0,2) || 'M INR' as Total_Revenue
from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
group by month_name,year,month
order by Total_Revenue desc;



-- Ouarterly Order Trends 

select 
	d.year,
	d.quarter,
	count(*) as Total_Order
from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
group by year,quarter
order by Total_Order desc;


-- Yearly Trends

select 
	d.year,
	count(*) as Total_Order
from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
group by year;


-- Orders by day of week(Mon-Sun)

select 
	TO_CHAR(d.full_date, 'Day') AS day_name,
	count(*) as Total_Order
from fact_swiggy_data f
join dim_date d on f.date_id = d.date_id
group by day_name;






-- Location Based Analysis

-- Top 10 Cities by Order Volume

select 
	dl.city,
	count(*) as Total_order
from fact_swiggy_data f
join dim_location dl on f.location_id = dl.location_id
group by dl.city 
order by Total_order desc
limit 10;



select 
	dl.city,
	round(sum(price_inr)/1000000.0,2) || 'M INR' as Total_Revenue
from fact_swiggy_data f
join dim_location dl on f.location_id = dl.location_id
group by dl.city 
order by Total_Revenue desc
limit 10;



-- Revenue Contribution by state

select
	dl.state,
	round(sum(price_inr)/1000000.0,2) || 'M INR' as Total_Revenue
from fact_swiggy_data f
join dim_location dl on f.location_id = dl.location_id
group by dl.state
order by Total_Revenue desc;






-- Food Performance

-- Top 10 Restaurants by orders

select 
	r.restaurant_name,
	count(*) as Total_order
from fact_swiggy_data f
join dim_restaurant r on f.restaurant_id = r.restaurant_id
group by r.restaurant_name
order by Total_order desc
limit 10;



-- Top 10 categories

select 
	c.category,
	count(*) as Total_order
from fact_swiggy_data f
join dim_category c on f.category_id = c.category_id
group by c.category
order by Total_order desc
limit 10;


-- Most Order Dishes

select 
	di.dish_name,
	count(*) as Total_order
from fact_swiggy_data f	
join dim_dish di on f.dish_id = di.dish_id
group by di.dish_name
order by Total_order desc
limit 10;


-- Cuisine Performance -> Orders + Avg rating

select 
	c.category,
	count(*) as Total_order,
	round(avg(rating),2) as Avg_rating
from fact_swiggy_data f
join dim_category c on f.category_id = c.category_id
group by c.category
order by Total_order desc
limit 10;



-- Customer Spending insights

select 
	case
		when price_inr < 100 then 'under 100'
		when price_inr between 100 and 199 then '100-199'
		when price_inr between 200 and 299 then '200-299'
		when price_inr between 399 and 499 then '399-499'
		else '500+'
	end as price_range,
	count(*) as total_order
from fact_swiggy_data
group by 
	case
		when price_inr < 100 then 'under 100'
		when price_inr between 100 and 199 then '100-199'
		when price_inr between 200 and 299 then '200-299'
		when price_inr between 399 and 499 then '399-499'
		else '500+'
	end	
order by total_order desc;



--Rating Count Distribution

select 
	rating,
	count(*) as total_rating
from fact_swiggy_data
group by rating 
order by rating;