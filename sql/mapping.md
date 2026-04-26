
## Section 9: One to Many
**1. Definition of one to many**
The One-to-Many relationship is defined as a relationship between two tables where a row from one table can have multiple matching rows in another table.

**2. PRIMARY KEY and FOREIGN KEY**
1. PRIMARY KEY: 
It identifies each record in a database table with UNIQUE values, and cannot contain NULL values. A table can have only one primary key, which may consist of single or multiple fields.

2. FOREIGN KEY: 
It is a key used to link two tables together. It is a field (or collection of fields) in one table that refers to the PRIMARY KEY in another table. The table containing the foreign key is called the child table, and the table containing the candidate key is called the referenced or parent table.

**3. Example use of FOREIGN KEY and PRIMARY KEY:**
```sql
-- Create customers and orders tables
CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  amount DECIMAL(8,2),
  customer_id INT,
  FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- insert data into customers and orders tables
INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

-- test the foreign key constraint (this will not -- work because there is no customer with id 98)
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/06/06', 33.67, 98);

-- find orders placed by George
SELECT id FROM customers WHERE last_name='George';
SELECT * FROM orders WHERE customer_id = 1;

-- or 
SELECT * FROM orders 
WHERE customer_id = (
  SELECT id FROM customers
  WHERE last_name='George'
);
```



## Section 10: Many to Many
**1. Definition of Many to Many**

**2. Example of Many to Many**
```sql
-- create tables for tv review database
CREATE TABLE reviewers (
	id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

CREATE TABLE series (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100),
	released_year YEAR(4),
	genre VARCHAR(100)
);

CREATE TABLE reviews (
	id INT AUTO_INCREMENT PRIMARY KEY,
	rating DECIMAL(2,1),
	series_id INT,
	reviewer_id INT,
	FOREIGN KEY(series_id) REFERENCES series(id),
	FOREIGN KEY(reviewer_id) REFERENCES reviewers(id)
);

-- insert data into the tables
INSERT INTO series (title, released_year, genre) VALUES
  ('Archer', 2009, 'Animation'),
  ('Arrested Development', 2003, 'Comedy'),
  ("Bob's Burgers", 2011, 'Animation'),
  ('Bojack Horseman', 2014, 'Animation'),
  ("Breaking Bad", 2008, 'Drama'),
  ('Curb Your Enthusiasm', 2000, 'Comedy'),
  ("Fargo", 2014, 'Drama'),
  ('Freaks and Geeks', 1999, 'Comedy'),
  ('General Hospital', 1963, 'Drama'),
  ('Halt and Catch Fire', 2014, 'Drama'),
  ('Malcolm In The Middle', 2000, 'Comedy'),
  ('Pushing Daisies', 2007, 'Comedy'),
  ('Seinfeld', 1989, 'Comedy'),
  ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
  ('Thomas', 'Stoneman'),
  ('Wyatt', 'Skaggs'),
  ('Kimbra', 'Masters'),
  ('Domingo', 'Cortes'),
  ('Colt', 'Steele'),
  ('Pinkie', 'Petit'),
  ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewer_id, rating) 
VALUES
  (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
  (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
  (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
  (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
  (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
  (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
  (7,2,9.1),(7,5,9.7),
  (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
  (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
  (10,5,9.9),
  (13,3,8.0),(13,4,7.2),
  (14,2,8.5),(14,3,8.9),(14,4,8.9);

-- INNER JOIN tables
-- find rating of tv series
SELECT 
  title, 
  rating 
FROM series
JOIN reviews
  ON series.id = reviews.series_id;

-- find average rating of tv series
SELECT 
  title, 
  AVG(rating) AS avg_rating
FROM series
JOIN reviews
  ON series.id = reviews.series_id
GROUP BY series.id
ORDER BY avg_rating;

-- find reviewers' reviews
SELECT
  first_name,
  last_name,
  rating
FROM reviewers
INNER JOIN reviews
  ON reviewers.id = reviews.reviewer_id;

-- find unreviewed series
SELECT title AS unreviewed_series
FROM series
LEFT JOIN reviews
  ON series.id = reviews.series_id
WHERE rating IS NULL;

-- find average genre rating
SELECT genre, 
  ROUND(AVG(rating), 2) AS avg_rating 
FROM series 
INNER JOIN reviews 
  ON series.id = reviews.series_id 
GROUP BY genre; 

-- find reviwers' status: name, rating, status
SELECT first_name, 
  last_name, 
  COUNT(rating) AS COUNT, 
  IFNULL(MIN(rating), 0) AS MIN, 
  IFNULL(MAX(rating), 0) AS MAX, 
  ROUND(Ifnull(AVG(rating), 0), 2) AS AVG, 
  IF(COUNT(rating) > 0, 'ACTIVE', 'INACTIVE') AS STATUS 
FROM reviewers 
LEFT JOIN reviews 
  ON reviewers.id = reviews.reviewer_id 
GROUP BY reviewers.id; 

-- find power users' status
SELECT first_name, 
  last_name, 
  COUNT(rating) AS COUNT, 
  IFNULL(MIN(rating), 0) AS MIN, 
  IFNULL(MAX(rating), 0) AS MAX, 
  ROUND(IFNULL(AVG(rating), 0), 2) AS AVG, 
  CASE 
    WHEN COUNT(rating) >= 10 THEN 'POWER USER' 
    WHEN COUNT(rating) > 0 THEN 'ACTIVE' 
    ELSE 'INACTIVE' 
  END AS STATUS 
FROM reviewers 
LEFT JOIN reviews 
  ON reviewers.id = reviews.reviewer_id 
GROUP BY reviewers.id; 

-- join 3 tables together to show the data
SELECT 
  title,
  rating,
  CONCAT(first_name,' ', last_name) AS reviewer
FROM reviewers
INNER JOIN reviews 
  ON reviewers.id = reviews.reviewer_id
INNER JOIN series
  ON series.id = reviews.series_id
ORDER BY title;
```


