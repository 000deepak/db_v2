

oracle pass : @Oracle01  
# One-to-one (1:1)
* one record from table A is related to a maximum of one record in table B.
* the primary key of table B (with no orphan record) must be the secondary key of table A (with orphan records).

> For example:
```sql
CREATE TABLE Gov(
    GID number(6) PRIMARY KEY, 
    Name varchar2(25), 
    Address varchar2(30), 
    TermBegin date,
    TermEnd date
); 

CREATE TABLE State(
    SID number(3) PRIMARY KEY,
    StateName varchar2(15),
    Population number(10),
    SGID Number(4) REFERENCES Gov(GID), 
    CONSTRAINT GOV_SDID UNIQUE (SGID)
);

INSERT INTO gov(GID, Name, Address, TermBegin) 
values(110, 'Bob', '123 Any St', '1-Jan-2009');

INSERT INTO STATE values(111, 'Virginia', 2000000, 110);
```

# One-to-many (1:M)
* one record from table A is related to one or more records in table B. 
* one record in table B cannot be related to more than one record in table A.
* the primary key of table A (the "one" table) must be the secondary key of table B (the "many" table).

> For example:
```sql
CREATE TABLE Vendor(
    VendorNumber number(4) PRIMARY KEY,
    Name varchar2(20),
    Address varchar2(20),
    City varchar2(15),
    Street varchar2(2),
    ZipCode varchar2(10),
    Contact varchar2(16),
    PhoneNumber varchar2(12),
    Status varchar2(8),
    StampDate date
);

INSERT INTO Vendor(VendorNumber, Name, Address, City,Street,ZipCode,Contact,PhoneNumber,Status,StampDate) 
values(110, 'Bob', '123 Any St','abc','cd',1234,'asdf',1234,'active', '1-Jan-2009');


CREATE TABLE Inventory(
    Item varchar2(6) PRIMARY KEY,
    Description varchar2(30),
    CurrentQuantity number(10) NOT NULL,
    VendorNumber number(10) REFERENCES Vendor(VendorNumber),
    ReorderQuantity number(10) NOT NULL
);

INSERT INTO Inventory(Item, Description, CurrentQuantity, VendorNumber,ReorderQuantity) 
values('Bob','des',1,110,1);
```


# Many-to-many (M:M)
* one record from table A is related to one or more records in table B and vice-versa.
* create a third table called "ClassStudentRelation" which will have the primary keys of both table A and table B.

> Example

```sql
CREATE TABLE Class(
    ClassID varchar2(10) PRIMARY KEY, 
    Title varchar2(30),
    Instructor varchar2(30), 
    Day varchar2(15), 
    Time varchar2(10)
);

CREATE TABLE Student(
    StudentID varchar2(15) PRIMARY KEY, 
    Name varchar2(35),
    Major varchar2(35), 
    ClassYear varchar2(10), 
    Status varchar2(10)
);  

CREATE TABLE ClassStudentRelation(
    StudentID varchar2(15) NOT NULL,
    ClassID varchar2(14) NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID), 
    FOREIGN KEY (ClassID) REFERENCES Class(ClassID),
    UNIQUE (StudentID, ClassID)
);
```