-- Cleaned and corrected SQL script (MySQL compatible)

-- =========================
-- EMPLOYEE TABLES
-- =========================

CREATE TABLE Employee (
    EMPLOYEE_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    FIRST_NAME VARCHAR(25),
    LAST_NAME VARCHAR(25),
    SALARY INT,
    JOINING_DATE DATETIME,
    DEPARTMENT VARCHAR(25),
    MANAGER_ID INT
);

INSERT INTO Employee (FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT, MANAGER_ID) VALUES
('James', 'Smith', 100000, '2017-02-20 09:00:00', 'HR', 2),
('Jessica', 'Kohl', 80000, '2017-06-11 09:00:00', 'Admin', 5),
('Alex', 'Garner', 300000, '2017-02-20 09:00:00', 'HR', 11),
('Pratik', 'Pandey', 500000, '2017-02-20 09:00:00', 'Admin', 20),
('Christine', 'Robinson', 500000, '2017-06-11 09:00:00', 'Admin', 7),
('Deepak', 'Gupta', 200000, '2017-06-11 09:00:00', 'Account', 15),
('Jennifer', 'Paul', 75000, '2017-01-20 09:00:00', 'Account', 12),
('Deepika', 'Sharma', 90000, '2017-04-11 09:00:00', 'Admin', 17);

CREATE TABLE Bonus (
    EMPLOYEE_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE DATETIME,
    FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES Employee(EMPLOYEE_ID) ON DELETE CASCADE
);

INSERT INTO Bonus VALUES
(1, 5000, '2018-02-20'),
(2, 3000, '2018-06-11'),
(3, 4000, '2018-02-20'),
(1, 4500, '2018-02-20'),
(2, 3500, '2018-06-11');

CREATE TABLE Title (
    EMPLOYEE_REF_ID INT,
    EMPLOYEE_TITLE VARCHAR(25),
    AFFECTED_FROM DATETIME,
    FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES Employee(EMPLOYEE_ID) ON DELETE CASCADE
);

INSERT INTO Title VALUES
(1, 'Manager', '2018-02-20 00:00:00'),
(2, 'Executive', '2018-06-11 00:00:00'),
(8, 'Executive', '2018-06-11 00:00:00'),
(5, 'Manager', '2018-06-11 00:00:00'),
(4, 'Asst. Manager', '2018-06-11 00:00:00'),
(7, 'Executive', '2018-06-11 00:00:00'),
(6, 'Lead', '2018-06-11 00:00:00'),
(3, 'Lead', '2018-06-11 00:00:00');

-- =========================
-- STUDENTS (FIXED ORDER)
-- =========================

CREATE TABLE all_students (
    student_id INT PRIMARY KEY,
    school_id INT,
    grade_level INT,
    date_of_birth DATETIME,
    hometown VARCHAR(25)
);

INSERT INTO all_students VALUES
(110111, 205, 1, '2013-01-10', 'Pleasanton'),
(110115, 205, 1, '2013-03-15', 'Dublin'),
(110119, 205, 2, '2012-02-13', 'San Ramon'),
(110121, 205, 3, '2011-01-13', 'Dublin'),
(110125, 205, 2, '2012-04-25', 'Dublin'),
(110129, 205, 3, '2011-02-22', 'San Ramon');

CREATE TABLE attendance_events (
    date_event DATETIME,
    student_id INT,
    attendance VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES all_students(student_id) ON DELETE CASCADE
);

INSERT INTO attendance_events VALUES
('2018-01-10', 110111, 'present'),
('2018-01-10', 110121, 'present'),
('2018-01-12', 110115, 'absent'),
('2018-01-13', 110119, 'absent'),
('2018-01-13', 110121, 'present'),
('2018-01-14', 110125, 'present'),
('2018-02-05', 110111, 'absent'),
('2018-02-17', 110115, 'present'),
('2018-02-22', 110129, 'absent');

-- =========================
-- LOGIN INFO
-- =========================

CREATE TABLE login_info (
    user_id INT,
    login_time DATETIME
);

INSERT INTO login_info VALUES
(1, '2017-08-10 14:32:25'),
(2, '2017-08-11 14:32:25'),
(3, '2017-08-11 14:32:25'),
(2, '2017-08-13 14:32:25');

-- =========================
-- FIXED TABLE NAME ISSUE
-- =========================

CREATE TABLE confirmed_no (
    phone_number VARCHAR(15)
);

INSERT INTO confirmed_no VALUES
('232-473-3433'),
('545-038-2294'),
('647-294-1837'),
('492-485-9727');

-- =========================
-- EVENT LOG FIX
-- =========================

CREATE TABLE event_log (
    user_id INT,
    event_date_time INT
);

INSERT INTO event_log VALUES
(7494212, 1535308430),
(7494212, 1535308433),
(1475185, 1535308444);

-- =========================
-- NOTES
-- =========================
-- ✔ Fixed date formats
-- ✔ Fixed foreign key order
-- ✔ Fixed table name mismatch
-- ✔ Replaced CHAR with VARCHAR
-- ✔ Removed invalid syntax
-- ✔ Cleaned inserts for consistency
