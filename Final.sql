/*
Query to show the manager's names at each store, with full address of property (street address, district, city and country)
*/

SELECT 
	s.store_id, s.first_name, s.last_name,
    a.address, a.district,
    c.city,
    co.country
FROM
	staff s
    	JOIN
	address a
ON
	s.address_id = a.address_id
		JOIN
	city c
ON
	a.city_id = c.city_id
		JOIN
	country co
ON
    c.country_id = co.country_id
order by
	s.store_id;
    
    
/*
Query to show inventories including inventory_id, store_id, titles, rating, rental rate and replacement cost
*/

SELECT 
	i.inventory_id, i.store_id,
	f.title, f.rating, f.rental_rate, f.replacement_cost
FROM
	inventory i
		JOIN
	film f
ON
	i.film_id = f.film_id
ORDER BY inventory_id;


/*
Query to show summary of inventories including inventory_id, store_id, titles, rating, rental rate and replacement cost
*/
-- for store 1 

SELECT 
	i.inventory_id, i.store_id,
	f.title, f.rating, f.rental_rate, f.replacement_cost
FROM
	inventory i
		JOIN
	film f
ON
	i.film_id = f.film_id
where store_id = 1
GROUP BY f.title
ORDER BY inventory_id;

-- for store 2 

SELECT 
	i.inventory_id, i.store_id,
	f.title, f.rating, f.rental_rate, f.replacement_cost
FROM
	inventory i
		JOIN
	film f
ON
	i.film_id = f.film_id
where store_id = 2
GROUP BY f.title
ORDER BY inventory_id;


/*
Query to show the diversity of the inventory in terms of replacement cost and film categories 
*/

-- For store 1 

SELECT
	COUNT(i.film_id) as number_of_film,
    AVG(f.replacement_cost) AS average_replacement_cost,
    SUM(f.replacement_cost) AS total_replacement_cost,
    c.name,
    i.store_id
FROM
	inventory i
		JOIN
	film f
ON
	i.film_id = f.film_id
		JOIN
	film_category fc
ON
	f.film_id = fc.film_id
		JOIN
	category c
ON
	fc.category_id = c.category_id
WHERE i.store_id = 1
GROUP BY c.category_id
ORDER BY number_of_film desc;

-- For store 2 

SELECT
	COUNT(i.film_id) as number_of_film,
    AVG(f.replacement_cost) AS average_replacement_cost,
    SUM(f.replacement_cost) AS total_replacement_cost,
    c.name,
    i.store_id
FROM
	inventory i
		JOIN
	film f
ON
	i.film_id = f.film_id
		JOIN
	film_category fc
ON
	f.film_id = fc.film_id
		JOIN
	category c
ON
	fc.category_id = c.category_id
WHERE i.store_id = 2
GROUP BY c.category_id
ORDER BY number_of_film desc;

/*
Query to show names of customers, the store they go to, whether active or not and their address 
*/

SELECT
	c.customer_id, c.first_name, c.last_name,
    CASE active
		WHEN 1 THEN 'active'
        ELSE 'inactive'
    end as active,
    c.store_id,
    a.address,
    ci.city,
    co.country
FROM
	customer c
		JOIN
	address a
ON
	c.address_id = a.address_id
		JOIN
	city ci
ON
	a.city_id = ci.city_id
		JOIN
	country co
ON
	ci.country_id = co.country_id
ORDER BY c.address_id;


/*
Query to show amount customers are spending and most valuable customer
*/

SELECT 
	c.customer_id, c.first_name, c.last_name,
	COUNT(r.customer_id) AS total_lifetime_rentals,
	SUM(p.amount) AS total_payment
FROM
	customer c
		JOIN
	rental r
ON 
	c.customer_id = r.customer_id
		JOIN
	payment p
ON
	r.customer_id = p.customer_id
GROUP BY customer_id
ORDER BY total_lifetime_rentals desc;


/*
Query to create table containing list of investors and advisors on a single table
*/

CREATE TABLE board_members
(
	board_member_id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    advisor VARCHAR(255),
    investor VARCHAR(255),
    position VARCHAR(255),
    company_name VARCHAR(255)
);

INSERT INTO board_members
(
    first_name,
    last_name,
    investor,
    company_name
)
SELECT
    first_name,
    last_name,
	ifnull(null, 'investor'),
	company_name
FROM
	investor;

INSERT INTO board_members
(
    first_name,
    last_name,
    advisor,
    position
)
SELECT
    first_name,
    last_name,
	ifnull(null, 'advisor'),
    CASE is_chairmain
    WHEN 1 THEN 'chairman'
    ELSE 'advisor'
    END AS position
FROM
	advisor;
    

/*
Query to show percentage of films in inventory for actors with 3 types of awards, 2 types of awards and 1 type of award
*/

-- Percentage of films for actors with 3 types of awards

SELECT 
	aa.awards, aa.actor_id,
    COUNT(i.film_id) as number_of_films,
    (COUNT(fa.film_id) / 4581 * 100) as percentage
FROM
	actor_award aa
		JOIN
	film_actor fa
ON
	aa.actor_id = fa.actor_id
		JOIN
	inventory i
ON
	fa.film_id = i.film_id
WHERE aa.awards like ('%Emmy, Oscar, Tony%')
GROUP BY aa.actor_id
order by actor_id;

-- Percentage of films for actors with 2 types of awards

SELECT 
	aa.awards, aa.actor_id,
    COUNT(i.film_id) as number_of_films,
    (COUNT(i.film_id) / 4581 * 100) as percentage
FROM
	actor_award aa
		JOIN
	film_actor fa
ON
	aa.actor_id = fa.actor_id
		JOIN
	inventory i
ON
	fa.film_id = i.film_id
WHERE aa.awards in ('Emmy, Tony', 'Emmy, Oscar', 'Oscar, Tony')
GROUP BY aa.actor_id
order by actor_id;

-- Percentage of films for actors with 1 types of awards

SELECT 
	aa.awards, aa.actor_id,
    COUNT(i.film_id) as number_of_films,
    (COUNT(i.film_id) / 4581 * 100) as percentage
FROM
	actor_award aa
		JOIN
	film_actor fa
ON
	aa.actor_id = fa.actor_id
		JOIN
	inventory i
ON
	fa.film_id = i.film_id
WHERE aa.awards in ('Emmy', 'Oscar', 'Tony')
GROUP BY aa.actor_id
order by actor_id;
