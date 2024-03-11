use sakila;

## 1. Write a query to display for each store its store ID, city, and country.
select * from store; # s.store_id, s.address_id
select * from address; # a.address_id, a.city_id
select * from city; # c.city_id, c.country_id, c.city
select * from country; # co.country_id, co.country

select s.store_id, c.city, co.country
from store s
join address a
on s.address_id = a.address_id
join city c 
on a.city_id = c.city_id
join country co
on c.country_id = co.country_id;

## 2. Write a query to display how much business, in dollars, each store brought in.
select * from store; # st.store_id
select * from staff; # s.store_id, s.staff_id
select * from payment; # p.staff_id, sum(p.amount) as total_amount

select st.store_id, sum(p.amount) as total_amount
from store st
join staff s on st.store_id = s.store_id
join payment p on s.staff_id = p.staff_id
group by st.store_id;

## 3. What is the average running time of films by category?
select * from film; # f.film_id, avg(f.length) as avg_running_time
select * from film_category; # fc.film_id, fc.category_id
select * from category; # c.category_id

select  c.category_id, c.name, f.film_id, round(avg(f.length)) as avg_running_time
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id, c.name, f.film_id;

## 4. Which film categories are longest?
select fc.film_id, c.category_id, c.name, f.length as duration
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id, c.name, fc.film_id
order by f.length desc
limit 10;

## 5. Display the most frequently rented movies in descending order.
select * from film; # f.film_id, f.title
select * from inventory; #i.film_id, i.inventory_id
select * from rental; # r.inventory_id, r.rental_id

select f.film_id, f.title, count(r.rental_id) as freq_rented
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
order by freq_rented desc;

## 6. List the top five genres in gross revenue in descending order.
select * from film; # f.film_id, f.rental_rate
select * from film_category; # fc.film_id, fc.category_id
select * from category; # c.category_id, c.name

select f.film_id, c.name, f.rental_rate
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by f.film_id, c.name
order by f.rental_rate desc
limit 5;

## 7. Is "Academy Dinosaur" available for rent from Store 1?
select * from film; # f.film_id, f.title
select * from inventory; # i.film_id, i.store_id, i.inventory_id
select * from store; # s.store_id
select * from rental; # r.inventory_id, r.rental_id

select f.film_id, f.title, r.rental_id, i.store_id
from film f
join inventory i on f.film_id = i.film_id
join store s on i.store_id = s.store_id
join rental r on  i.inventory_id = r.inventory_id
where f.title = 'Academy Dinosaur' and s.store_id = 1
order by f.title asc;

## Yes, "Academy Dinosaur" is available for rent in Store 1.



