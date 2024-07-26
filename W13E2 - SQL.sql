-- 2)SCOPRITE QUANTI CLIENTI SI SONO REGISTRATI NEL 2006
SELECT
count(first_name),
year(create_date) 
FROM customer
where year(create_date) = 2006
group by Year(create_date);

-- 3)TROVATE IL NUMERO TOTALE DI NOLEGGI EFFETTUATI IL GIORNO 1/1/2006
SELECT
count(*) as totale_noleggi,
date(rental_date) as data_noleggio
FROM rental
where date(rental_date) = '2005-05-24'
group by date(rental_date);

-- 4)ELENCATE TUTTI I FILM NOLEGGIATI NELL ULTIMA SETTIMANA E TUTTE LE INFORMAZIONI LEGATE AL CLIENTE CHE LI HA NOLEGGIATI
SELECT 
    film.title AS titolo_film,
    customer.customer_id AS id_cliente,
    customer.first_name AS nome,
    customer.last_name AS cognome,
    customer.email AS email,
    rental.rental_date AS data_noleggio
FROM
    film
        JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    rental ON inventory.inventory_id = rental.inventory_id
        JOIN
    customer ON rental.customer_id = customer.customer_id
    where  date(rental.rental_date) between '2006-02-08' and '2006-02-014'
ORDER BY data_noleggio DESC;
    
-- 5)CALCOLATE LA DURATA MEDIA DEL NOLEGGIO PER OGNI CATEGORIA DI FILM
SELECT 
    category.name,
    AVG(film.rental_duration)
   FROM
    film
        JOIN
    film_category ON film.film_id = film_category.film_id
        JOIN
    category ON film_category.category_id = category.category_id
    group by category.name;
    
-- 6)TROVATE LA DURATA DEL NOLEGGIO PIU LUNGO
SELECT 
    MAX(rental_duration)
FROM
    film;
    
select
datediff(return_date,rental_date) as durata_noleggio
from rental
order by durata_noleggio desc;


