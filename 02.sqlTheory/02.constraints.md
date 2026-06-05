SQL Constraints
Constraints are used to limit the type of data that can go into a table.
Constraints can be specified when a table is created (with the CREATE TABLE statement) or after
the table is created (with the ALTER TABLE statement).

We will focus on the following constraints:
* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* CHECK
* DEFAULT

## SQL NOT NULL Constraint
The NOT NULL constraint enforces a column to NOT accept NULL values.
The NOT NULL constraint enforces a field to always contain a value. This means that you cannot
insert a new record, or update a record without adding a value to this field.
```sql
The following SQL enforces the "P_Id" column and the "LastName" column to not accept NULL
values:

CREATE TABLE Persons
(
P_Id int NOT NULL,
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
City varchar(255)
)
```