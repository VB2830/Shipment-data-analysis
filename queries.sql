--display all the data from the orders_data table 
select * from orders_data


--Write a SQL query to list all distinct cities where orders have been shipped.
select distinct city from orders_data 


--Calculate the total selling price and profits for all orders.
select [Order Id], sum(Quantity*Unit_Selling_Price) as 'Total Selling Price',
cast(sum(quantity*unit_profit) as decimal(10,2)) as 'Total Profit'
from orders_data
group by [Order Id]
order by [Total Profit] desc


-- Write a query to find all orders from the 'Technology' category 
-- that were shipped using 'Second Class' ship mode, ordered by order date.
select [Order Id], [Order Date]
from orders_data
where category = 'Technology' and [Ship Mode] = 'Second Class'
order by [order date]


-- Write a query to find the average order value
select cast(avg(quantity * unit_selling_price) as decimal(10, 2)) as AOV
from orders_data


-- find the city with the highest total quantity of products ordered.
select top 1 city, sum(quantity) as 'Total Quantity'
from orders_data
group by city order by [Total Quantity] desc


-- Use a window function to rank orders in each region by quantity in descending order.
select [order id], region as 'Region', quantity as 'Total_Quantity',
dense_rank() over (partition by region order by quantity desc) as rnk
from orders_data 
order by region, rnk 


-- Write a SQL query to list all orders placed in the first quarter of any year (January to March), including the total cost for these orders.
select [Order Id], sum(Quantity*unit_selling_price) as 'Total Value'
from orders_data
where month([order date]) in (1,2,3) 
group by [Order Id]
order by [Total Value] desc


-- Find top 10 highest profit generating products 
select top 10 [product id],sum([Total Profit]) as profit
from [orders_data]
group by [product id]
order by profit desc


--find top 3 highest selling products in each region
with cte as (
select region, [product id], sum(quantity*Unit_selling_price) as sales
, row_number() over(partition by region order by sum(quantity*Unit_selling_price) desc) as rn
from [orders_data]
group by region, [product id]
) 
select * 
from cte
where rn<=3

