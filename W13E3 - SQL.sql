-- 1)IDENTIFICATE TUTTI I CLIENTI CHE NON HANNO EFFETTUATO NESSUN NOLEGGIO A GENNAIO 2006
SELECT *
FROM customer C
WHERE C.CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID 
                            FROM RENTAL WHERE YEAR(RENTAL_DATE)=2006 
                                            AND MONTH(RENTAL_DATE)=01);
-- 2)ELENCATE TUTTI I FILM CHE SONO STATI NOLEGGIATI PIU DI 10 VOLTE NELL ULTIMO QUARTO DEL 2005
SELECT 
film.film_id,
film.title,
COUNT(rental_id)    
FROM
    film
        JOIN
    inventory ON film.film_id = inventory.film_id
        JOIN
    customer ON inventory.store_id = customer.store_id
        JOIN
    rental ON customer.customer_id = rental.customer_id
    where QUARTER(rental_date)=1 AND YEAR(rental_date)=2006
    GROUP BY 1,2;
    
    
-- 3)TROVATE IL NUMERO DI NOLEGGI EFFETTUATI IL GIORNO 1/1/2006
SELECT
COUNT(*) as n_noleggi
FROM rental
where date(rental_date) = '2006-01-01';

-- 4)CALCOLATE LA SOMMA DEGLI INCASSI GENERATI NEI WEEKEND(SABATO E DOMENICA)
SELECT
dayname(payment_date),
sum(amount)
FROM payment
where dayname(payment_date) in('Saturday','Sunday')
group by dayname(payment_date);

-- 5)INDIVIDUATE IL CLIENTE CHE HA SPESO DI PIU IN NOLEGGI
SELECT 
    customer.first_name, customer.last_name, SUM(payment.amount)
FROM
    customer
        JOIN
    payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 1;

-- 6)ELENCATE I 5 FILM CON LA MAGGIOR DURATA MEDIA DI NOLEGGIO
SELECT
film.title,
avg(film.rental_duration) as durata_media_noleggio
FROM film
group by title
order by durata_media_noleggio desc
limit 5;

-- 7)CALCOLATE IL TEMPO MEDIO TRA DUE NOLEGGI CONSECUTIVI DA PARTE DI UN CLIENTE
SELECT CUSTOMER_ID, AVG(DIFFERENZA_NOLEGGI_CONSECUTIVI)
FROM(
SELECT DISTINCT
A.*,
RR1.RENTAL_DATE AS DATA_NOLEGGIO_PRECEDENTE,
RR2.RENTAL_DATE AS DATA_NOLEGGIO_SUCCESSIVO,
DATEDIFF(RR2.RENTAL_DATE, RR1.RENTAL_DATE ) DIFFERENZA_NOLEGGI_CONSECUTIVI
FROM(
SELECT 
r1.customer_id, 
r1.rental_id, 
min(r2.rental_id) AS NOLEGGIO_SUCCESSIVO
FROM
rental r1
  LEFT JOIN
        rental r2 ON r1.customer_id = r2.customer_id AND r2.rental_id > r1.rental_id
-- where r1.customer_id=1
-- and r2.customer_id=1
GROUP BY r1.customer_id, r1.rental_id) A 
LEFT JOIN RENTAL RR1 ON A.CUSTOMER_ID=RR1.CUSTOMER_ID AND A.RENTAL_ID=RR1.RENTAL_ID
LEFT JOIN RENTAL RR2 ON A.CUSTOMER_ID=RR2.CUSTOMER_ID AND A.NOLEGGIO_SUCCESSIVO=RR2.RENTAL_ID) AA
GROUP BY CUSTOMER_ID;


-- 8)INDIVIDUATE IL NUMERO DI NOLEGGI PER OGNI MESE DEL 2005
SELECT
YEAR(rental_date) as anno_noleggio,
month(rental_date) as mese_noleggio,
count(*) as noleggi_per_mese
FROM rental
GROUP BY year(rental_date),month(rental_date)
having anno_noleggio = 2005;

-- 9)TROVATE I FILM CHE SONO STATI NOLEGGIATI 2 VOLTE LO STESSO GIORNO
SELECT F.TITLE, COUNT(RENTAL_DATE) AS N1, COUNT(DISTINCT DATE(RENTAL_DATE)) AS N2
FROM RENTAL R
JOIN INVENTORY I ON I.INVENTORY_ID=R.INVENTORY_ID
JOIN FILM F ON I.FILM_ID=F.FILM_ID
-- WHERE F.TITLE ='CLUB GRAFFITI'
GROUP BY 1
HAVING N1<>N2
ORDER BY 1;

SELECT * -- F.TITLE, COUNT(RENTAL_DATE) AS N1, COUNT(DISTINCT DATE(RENTAL_DATE)) AS N2
FROM RENTAL R
JOIN INVENTORY I ON I.INVENTORY_ID=R.INVENTORY_ID
JOIN FILM F ON I.FILM_ID=F.FILM_ID
WHERE F.TITLE ='CLUB GRAFFITI';
-- GROUP BY 1
-- HAVING N1<>N2
-- ORDER BY 1;

-- 10)CALCOLATE IL TEMPO MEDIO DI NOLEGGIO
SELECT 
    AVG(DATEDIFF(return_date, rental_date)) AS durata_noleggio
FROM
    rental;

 
