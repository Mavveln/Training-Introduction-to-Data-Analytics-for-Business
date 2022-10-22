-----------------------------------------------------------------------------------------
                                    --### 1. GROUP BY ###--
-----------------------------------------------------------------------------------------
-- GROUP BY SYNTAX --
SELECT column1, function_name(column2)
FROM table_name
WHERE condition
GROUP BY column1, column2
ORDER BY column1, column2;

-- GROUP BY EXAMPLE --
-- Hitung jumlah film perkategori
SELECT category_id, COUNT(category_id) as count
FROM film_category
GROUP BY category_id
ORDER BY count DESC;
-----------------------------------------------------------------------------------------





-----------------------------------------------------------------------------------------
                                    --### 2. HAVING ###--
-----------------------------------------------------------------------------------------
-- HAVING SYNTAX --
SELECT column1, function_name(column2)
FROM table_name
WHERE condition
GROUP BY column1, column2
HAVING condition
ORDER BY column1, column2;

-- HAVING EXAMPLE --
-- Pilih semua kategori film dengan jumlah minimal 65 film per kategorinya
SELECT category_id, COUNT(category_id)
FROM film_category
GROUP BY category_id
HAVING COUNT(category_id) > 65;
-----------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------
                                    --### 3. CASE ###--
-----------------------------------------------------------------------------------------
-- CASE SYNTAX --
SELECT column1, column2,
CASE 
    WHEN when_value THEN statement_list
    [WHEN when_value THEN statement_list] ...
    [ELSE statement_list]
END CASE
FROM tablename;

-- CASE EXAMPLE --
/* Beri label untuk film dengan ketentuan: 
        > 100 mins: long movie
        < 50 mins: short movie
        50-100 mins: intermediate
*/
SELECT title, length,
CASE
    WHEN length > 100 THEN 'Long Movie'
    WHEN length < 50 THEN 'Short Movie'
    ELSE 'Intermediate Movie'
END AS MovieLength
FROM film
-----------------------------------------------------------------------------------------





-----------------------------------------------------------------------------------------
                            --### 4. HANDS ON & EXERCISE ###--
                                 -- SINGLE TABLE NO JOIN --
-----------------------------------------------------------------------------------------
--QUESTION:
/* Kelompokan film berdasarkan lama peminjaman!
CLUE:
    a. Gunakan tabel film
    b. Gunakan GROUP BY
*/
--ANSWER:
SELECT rental_duration, COUNT(*) as count
FROM film
GROUP BY rental_duration
ORDER BY count DESC;
-----------------------------------------------------------------------------------------
--QUESTION:
/* Kelompokan aktor berdasarkan nama belakang!
CLUE:
    a. Gunakan tabel film_actor
    b. Gunakan GROUP BY
*/
--ANSWER:
SELECT last_name, COUNT(*) AS count
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 3
ORDER BY count DESC;
-----------------------------------------------------------------------------------------
--QUESTION
/* Kelompokan film berdasarkan ratingnya dan hitung: 
    a. rata-rata pada setiap ratingnya
    b. jumlah film setiap rating
    c. total replacement cost untuk setiap rating
    d. tampilkan hanya yang memiliki rata-rata durasi lebih dari 115 minutes
*/
--ANSWER:
SELECT rating, 
       ROUND(AVG(length)) as duration, 
       COUNT(*) as count,
       SUM(replacement_cost) as cost
FROM film
GROUP BY rating
HAVING ROUND(AVG(length)) > 115;
-----------------------------------------------------------------------------------------
--QUESTION:
/*  DVD ingin tahu komposisi orang yang meminjam berdasarkan jumlah pembayaran.
    Kelompokan nominal pembayaran berdasarkan rentang dan hitung total setiap kelompok:
      a. Peminjaman lebih dari $10, beri label 'Sultan'
      b. Peminjaman antara $5 sampai $10, beri label 'Middle Class' 
      c. Peminjaman kurang dari $5, beri label 'Anak Kos'
CLUE: 
      a. Gunakan tabel payment
      b. Gunakan GROUP BY
      c. Gunakan CASE
*/
--ANSWER:
SELECT
CASE
    WHEN  amount > 10 THEN 'Sultan'
    WHEN  amount < 5 THEN 'Anak Kos'
    ELSE 'Middle Class'
END AS rental_class,
COUNT(*) as jumlah_customer
FROM payment
GROUP BY rental_class; 
-----------------------------------------------------------------------------------------
--QUESTIONS:
/* Diasumsikan standar lama peminjaman DVD sama, yaitu 5 hari (karena belum belajar JOIN)
   Tampilkan berapa banyak peminjaman yang:
      a. dikembalikan lebih awal (returned early) atau kurang dari 5 hari
      b. dikemablikan tepat waktu (returned on time) tepat 5 hari
      c. dikembalikan terlambat (returned late) lebih dari 5 hari
CLUE: 
      a. gunakan tabel rental
      b. gunakan fungsi date_part untuk pengurangan hari
      c. gunakan GROUP BY
      d. gunakan CASE WHEN
*/
-- ANSWER:
SELECT
CASE
    WHEN  date_part('day', return_date - rental_date) < 5 THEN 'Returned Early'
    WHEN  date_part('day', return_date - rental_date) = 5 THEN 'Returned On Time'
    ELSE 'Returned Late'
END AS Status_Return,
COUNT(*) as total_films
FROM rental
GROUP BY Status_Return;
-----------------------------------------------------------------------------------------
--QUESTION:
/* Gunakan hanya tabel film_category, hitung berapa banyak film dengan category Sci-fi, 
Horror dan Animation dengan CASE WHEN.
    a. Animation category_id 2
    b. Horror category_id 11
    c. Sci-fi category_id 14
CLUE:
    a. Gunakan tabel film_category
    b. Gunakan GROUP BY
*/
--ANSWER:
SELECT
CASE
    WHEN  category_id = 2 THEN 'Animation'
    WHEN  category_id = 11 THEN 'Horror'
    WHEN  category_id = 14 THEN 'Scifi'
    ELSE 'Others'
END AS category,
COUNT(*) as total_films
FROM film_category
GROUP BY category
-----------------------------------------------------------------------------------------
--QUESTION
/* Kelompokan jumlah film berdasarkan rental_rate dengan kentuan berikut: 
    a. Durasi/lenght lebih dari 100 menit
    b. Rating PG, PG-13 dan NC-17
    c. Rental_Rate harus lebih dari 4
*/
--ANSWER:
SELECT rental_rate, COUNT(*) as count
FROM film
WHERE length > 100 AND rating IN ('PG', 'PG-13', 'NC-17')
GROUP BY rental_rate
HAVING rental_rate > 4
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
                                    -- LIST ALL TABLES ---
-----------------------------------------------------------------------------------------
SELECT * FROM actor
SELECT * FROM address
SELECT * FROM category
SELECT * FROM city
SELECT * FROM country
SELECT * FROM customer
SELECT * FROM film
SELECT * FROM film_actor
SELECT * FROM film_category
SELECT * FROM inventory
SELECT * FROM language
SELECT * FROM payment
SELECT * FROM rental
SELECT * FROM staff
SELECT * FROM store

