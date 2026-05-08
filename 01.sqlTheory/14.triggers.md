## Section 15: SQL Database Trigger
**1. Definition:**

A database trigger is procedural code that is automatically executed in response to certain events on a particular table or view in a database. The trigger is mostly used for maintaining the integrity of the information on the database.

**2. Create table to explain concept**
```sql
CREATE TABLE users (
  username VARCHAR(100),
  age INT
);

-- delimiter create an execution block
DELIMITER $$
  CODE
$$
DELIMITER ;

-- TRIGGER template
DELIMITER $$ 
CREATE TRIGGER triggerName
  triggerTime triggerEvent ON tablename FOR EACH ROW
  BEGIN
    DO SOMETHING HERE
  END;
$$
DELIMITER ;

-- checking age before insert data
DELIMITER $$

CREATE TRIGGER must_be_adult
  BEFORE INSERT ON users FOR EACH ROW
  BEGIN
    IF NEW.age < 18
    THEN
      SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Must be an adult!';
    END IF;
  END;
$$

DELIMITER ;

-- the following instruction won't work after adding the above trigger
INSERT INTO users(username, age)
VALUES("Tim", 15); -- Tim's age < 18
```

**3. Trigger to prevent following users themselves (Above Instagram Clone Database)**
```sql
DELIMITER $$

CREATE TRIGGER prevent_self_follows
  BEFORE INSERT ON follows FOR EACH ROW
  BEGIN
    IF NEW.follower_id = NEW.followee_id
    THEN 
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'You cannot follow yourself!';
    END IF;
  END;
$$

DELIMITER ;
```

**4. Trigger to Capture unfollowers**
```sql
DELIMITER $$

CREATE TRIGGER capture_unfollow
  AFTER DELETE ON follows FOR EACH ROW
  BEGIN
    INSERT INTO unfollows
    SET
      follower_id = OLD.follower_id,
      followee_id = OLD.followee_id;
  END;
$$

DELIMITER ;
```

**5. Listing TRIGGER**
```sql
SHOW TRIGGERS;
```

**6. Drop TRIGGER**
```sql
DROP TRIGGER trigger_name;
```
## The SQL UNION Operator
The UNION operator is used to combine the result-set of two or more SELECT statements.

Notice that each SELECT statement within the UNION must have the same number of columns.

The columns must also have similar data types. Also, the columns in each SELECT statement must
be in the same order.
```sql
SELECT column_name(s) FROM table_name1
UNION
SELECT column_name(s) FROM table_name2
```
>Note: The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL.
```SQL
SELECT column_name(s) FROM table_name1
UNION ALL
SELECT column_name(s) FROM table_name2
```
PS: The column names in the result-set

## SELECT INTO
The SELECT INTO statement selects data from one table and inserts it into a different table.
The SELECT INTO statement is most often used to create backup copies of tables.

```java
We can select all columns into the new table:
SELECT *
INTO new_table_name [IN externaldatabase]
FROM old_tablename

Or we can select only the columns we want into the new table:
SELECT column_name(s)
INTO new_table_name [IN externaldatabase]
FROM old_tablename
```