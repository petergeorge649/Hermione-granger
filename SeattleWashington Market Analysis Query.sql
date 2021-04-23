SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;


-- 4.Select all the data from table house_price_data to check if the data was imported correctly
select * from house_price_regression.properties_data;

-- 5. Use the alter table command to drop the column date from the database
ALTER TABLE house_price_regression.properties_data
DROP DATE;

-- to check if date column still exist
select * from house_price_regression.properties_data
LIMIT 10;

-- 6. Use sql query to find how many rows of data you have.
-- you can count any of your columns 
select count(id) from house_price_regression.properties_data;
select count(*) from house_price_regression.properties_data;

-- 7. Now we will try to find the unique values in some of the categorical columns:
select distinct(bedrooms) as distinct_value from house_price_regression.properties_data;
select distinct(bathrooms) as distinct_value from house_price_regression.properties_data;
select distinct(floors) as distinct_value from house_price_regression.properties_data;
select distinct('condition') as distinct_value from house_price_regression.properties_data;
select distinct(grade) as distinct_value from house_price_regression.properties_data;


-- 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
select id, price 
from house_price_regression.properties_data
order by 2 desc
limit 10;

-- 9. What is the average price of all the properties in your data?
select avg(price) as avg from house_price_regression.properties_data;
select sum(price) as sum from house_price_regression.properties_data;

-- 10. In this exercise we will use simple group by to check the properties 
-- of some of the categorical variables in our data
-- a. What is the average price of the houses grouped by bedrooms? The returned result should 
-- have only two columns, bedrooms and Average of the prices. Use an alias to change the name 
-- of the second column.
select bedrooms, avg(price) as avg_price from house_price_regression.properties_data
group by 1;

-- b. What is the average sqft_living of the houses grouped by bedrooms? The returned result 
-- should have only two columns, bedrooms and Average of the sqft_living. Use an alias to 
-- change the name of the second column.
select avg(sqft_living) as avg_sqft_living,bedrooms
 from house_price_regression.properties_data
 GROUP BY bedrooms;

-- c. What is the average price of the houses with a waterfront and without a waterfront? The 
-- returned result should have only two columns, waterfront and Average of the prices. Use 
-- an alias to change the name of the second column.

select waterfront, avg(price) as avg_price 
from house_price_regression.properties_data
group by 1;

-- d. Is there any correlation between the columns condition and grade? You can analyse this by 
-- grouping the data by one of the variables and then aggregating the results of the other 
-- column. Visually check if there is a positive correlation or negative correlation or no 
-- correlation between the variables.

select 'condition', avg(grade) as 'avg_grade' 
from house_price_regression.properties_data
group by 1;
-- the output is positive from question 10..d.


-- 11. One of the customers is only interested in the following houses:

-- Number of bedrooms either 3 or 4,  Bathrooms more than 3,  One Floor, No waterfront, 
-- Condition should be 3 at least,  Grade should be 5 at least, Price less than 300000
SELECT *
FROM house_price_regression.properties_data
WHERE (bedrooms = 3 or   bedrooms = 4)and (bathrooms > 3)and (floors = 1)and (waterfront = 0)
and (grade >=5)and (price > 300000);


-- I got it right but i have problem adding  the condion with the column ('condition' = 3);


-- 12. Your manager wants to find out the list of properties whose prices are twice more than
-- the average of all the properties in the database. Write a query to show them the list of 
-- such properties. You might need to use a sub query for this problem.

SELECT * 
FROM house_price_regression.properties_data
WHERE price > (select avg(price) *2 as avg_price 
from house_price_regression.properties_data);


-- below code will give you the average price * 2
select avg(price) *2 as avg_price 
from house_price_regression.properties_data;

-- 13. Since this is something that the senior management is regularly interested in, 
-- create a view of the same query.

CREATE VIEW senior_management AS
SELECT * 
FROM house_price_regression.properties_data
WHERE price > (select avg(price) *2 as avg_price 
from house_price_regression.properties_data);


-- 14.Most customers are interested in properties with three or four bedrooms. What is the 
-- difference in average prices of the properties with three and four bedrooms?
SELECT bedrooms, AVG(price)
FROM house_price_regression.properties_data
WHERE (bedrooms = 3 OR bedrooms = 4)
GROUP BY 1;

-- 15. What are the different locations where properties are available in your database? 
-- (distinct zip codes)
SELECT  DISTINCT(zipcode) AS location
FROM house_price_regression.properties_data;

-- 16. Show the list of all the properties that were renovated.
SELECT * 
FROM house_price_regression.properties_data
WHERE yr_renovated > 0;

--- THIS QUERY SHOWS THE FULL DATASET SO AS TO VIEW THE RENOVATED COLUMN.
SELECT * 
FROM house_price_regression.properties_data;

-- 17.Provide the details of the property that is the 11th most expensive property in your 
-- database.
-- this gives us the 11 most expensive properties
SELECT * FROM house_price_regression.properties_data
ORDER BY price DESC 
LIMIT 11;

-- this gives us the 11th most expensive properties
with a as 
(SELECT * 
FROM house_price_regression.properties_data
ORDER BY price DESC 
LIMIT 11)
select * from a limit 1 offset 10;












