/*
Query to select a list of staff members including their first name, last name, email address and the store id where they work
*/

SELECT 
	first_name, last_name, email, store_id 
FROM 
	staff;
    

/*
Query to return count of inventory held at each stores 
*/

-- For store 1
SELECT 
	COUNT(inventory_id) as total
FROM
	inventory
WHERE
	store_id = 1;
    
-- For store 2
SELECT 
	COUNT(inventory_id) as total
FROM
	inventory
WHERE
	store_id = 2;
    
    
/*
Query to get a list of active customers from each store 
*/

-- For store 1
SELECT
	COUNT(customer_id) as active_customers
FROM 
	customer
WHERE active = 1 and store_id = 1;

-- For store 2
SELECT
	COUNT(customer_id) as active_customers
FROM 
	customer
WHERE active = 1 and store_id = 2; 


/*
Query to show count of all customer email address
*/

select 
	COUNT(email) as total
from
	customer;
    

/* 
Query to show count of unique film titles in the inventory at each stores and the count of unique film categories 
*/

-- For store 1
select
	COUNT(DISTINCT film_id) as no_of_films
FROM
	inventory
WHERE
	store_id = 1;
    
-- For store 2
select
	COUNT(DISTINCT film_id) as no_of_films
FROM
	inventory
WHERE
	store_id = 2;
    
--  count of unique film categories
select
	COUNT(DISTINCT category_id) AS no_of_film_categories
from
film_category;


/*
Query to show most expensive, least expensive and average cost of replacement of films
*/

select 
	MAX(replacement_cost) AS most_expensive, 
    MIN(replacement_cost) AS least_expensive,
    AVG(replacement_cost) AS average_replacement_cost
from
	film;
    

/*
Query to show average payment and highest payment 
*/

select 
	AVG(amount) as average_payment,
	MAX(amount) as maximum_payment
from
	payment;
    

/*
Query to show customer ids with total no of rentals 
*/

select 
	DISTINCT customer_id, 
	COUNT(customer_id) AS total_no_of_rentals
from 
	rental
GROUP BY
	customer_id
order by
	total_no_of_rentals desc;