## Agenda

 - Views 
 - Window function

## Views

Imagine in sakillaDB, I frequently have queries of the following type:
 - Given an actor, give me the name of all films they have acted in. 
 - Given a film, give me the name of all actors who have acted in it. 

Getting the above requires a join across 3 tables, `film`, `film_actor` and `actor`. 

Why is that an issue?
 - Writing these queries time after time is cumbersome. Infact imagine queries that are even more complex - requiring joins across a lot of tables with complex conditions. Writing those everytime with 100% accuracy is difficult and time-taking. 
 - Not every team would understand the schema really well to pull data with ease. And understanding the entire schema for a large, complicated system would be hard and would slow down teams. 

So, what's the solution? 
Databases allow for creation of views. Think of views as an alias which when referred is replaced by the query you store with the view.

So, a query like the following:

```sql
CREATE OR REPLACE view actor_film_name AS

SELECT
   concat(a.first_name, a.last_name) AS actor_name,
   f.title AS file_name
FROM actor a
  JOIN film_actor fa 
    ON fa.actor_id = a.actor_id 
  JOIN film f
    ON f.film_id = fa.film_id
```


**Note that a view is not a table.** It runs the query on the go, and hence data redundancy is not a problem. 

### Operating with views

Once a view is created, you can use it in queries like a table. Note that in background the view is replaced by the query itself with view name as alias. 
Let's see with an example. 

```sql
SELECT film_name FROM
actor_film_name WHERE actor_name = "JOE SWANK"
```

OR 

```sql
SELECT actor_name FROM
actor_file_name WHERE film_name = "AGENT TRUMAN"
```

If you see, with views it's super simple to write queries that I write frequently. Lesser chances to make an error.
Note that however, actor_file_name above is not a separate table but more of an alias.

An easy way to understand that is that assume every occurrence of `actor_file_name` is replaced by

```sql
(SELECT
   concat(a.first_name, a.last_name) AS actor_name,
   f.title AS file_name
FROM actor a
  JOIN film_actor fa 
    ON fa.actor_id = a.actor_id 
  JOIN film f
    ON f.film_id = fa.film_id) AS actor_file_name
```

**Caveat:** Certain DBMS natively support materialised views. Materialised views are views with a difference that the views also store results of the query. This means there is redundancy and can lead to inconsistency / performance concerns with too many views. But it helps drastically improve the performance of queries using views. MySQL for example does not support materialised views. Materialised views are tricky and should not be created unless absolutely necessary for
performance. 

#### How to best leverage views

Imagine there is an enterprise team at Scaler which helps with placements of the students. 
Should they learn about the entire Scaler schema? Not really. They are only concerned with student details, their resume, Module wise PSP, Module wise Mock Interview clearance, companies details and student status in the companies where they have applied.  

In such a case, can we create views which gets all of the information in 1 or 2 tables? If we can, then they need to only understand those 2 tables and can work with that. 

#### More operations on views

**How to get all views in the database:**

```sql
SHOW FULL TABLES WHERE table_type = 'VIEW';
```

**Dropping a view** 

```sql
DROP VIEW actor_file_name;
```

**Updating a view**

```sql
ALTER view actor_film_name AS

 SELECT
    concat(a.first_name, a.last_name) AS actor_name,
    f.title AS file_name
 FROM actor a
   JOIN film_actor fa
     ON fa.actor_id = a.actor_id
   JOIN film f
     ON f.film_id = fa.film_id
```

**Note:** Not recommended to run update on views to update the data in the underlying tables. Best practice to use views for reading information. 

**See the original create statement for a view**

```sql
SHOW CREATE TABLE actor_film_name
```