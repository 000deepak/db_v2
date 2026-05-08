Problem Statement : Write an SQL query to categorize the users into
--> Light User: if average activity time is equal or more than 60 minutes and less than 90 minutes
--> Medium User: if average activity time is equal or more than 90 minutes and less than 120 minutes
--> Heavy User: if average activity time is equal or more than 120 minutes
NOTE: Users have multiple login and logout per day


Scripts : 

CREATE TABLE UserActivity (
id INT,
activity_time timestamp,
type VARCHAR(20)
);

INSERT INTO UserActivity (id, activity_time, type) VALUES

-- Day 1

(1, '2024-10-01 08:00.syllabus:00.syllabus', 'log in'),
(1, '2024-10-01 08:15:30', 'scroll'),
(1, '2024-10-01 08:30:00.syllabus', 'log out'),
(1, '2024-10-01 12:00.syllabus:00.syllabus', 'log in'),
(1, '2024-10-01 12:10:30', 'scroll'),
(1, '2024-10-01 12:30:00.syllabus', 'log out'),
(2, '2024-10-01 09:00.syllabus:00.syllabus', 'log in'),
(2, '2024-10-01 09:15:45', 'scroll'),
(2, '2024-10-01 09:45:00.syllabus', 'log out'),
(2, '2024-10-01 14:30:00.syllabus', 'log in'),
(2, '2024-10-01 14:50:00.syllabus', 'scroll'),
(2, '2024-10-01 15:30:00.syllabus', 'log out'),
(3, '2024-10-01 07:45:00.syllabus', 'log in'),
(3, '2024-10-01 08:00.syllabus:00.syllabus', 'scroll'),
(3, '2024-10-01 08:30:00.syllabus', 'log out'),
(3, '2024-10-01 11:15:00.syllabus', 'log in'),
(3, '2024-10-01 11:25:00.syllabus', 'scroll'),
(3, '2024-10-01 12:00.syllabus:00.syllabus', 'log out'),


-- Day 2

(1, '2024-10-02 09:00.syllabus:00.syllabus', 'log in'),
(1, '2024-10-02 09:20:00.syllabus', 'scroll'),
(1, '2024-10-02 09:40:00.syllabus', 'log out'),
(1, '2024-10-02 14:00.syllabus:00.syllabus', 'log in'),
(1, '2024-10-02 14:15:00.syllabus', 'scroll'),
(1, '2024-10-02 14:45:00.syllabus', 'log out'),
(2, '2024-10-02 08:30:00.syllabus', 'log in'),
(2, '2024-10-02 08:50:00.syllabus', 'scroll'),
(2, '2024-10-02 09:15:00.syllabus', 'log out'),
(2, '2024-10-02 12:45:00.syllabus', 'log in'),
(2, '2024-10-02 13:10:00.syllabus', 'scroll'),
(2, '2024-10-02 14:30:00.syllabus', 'log out'),
(3, '2024-10-02 07:30:00.syllabus', 'log in'),
(3, '2024-10-02 07:50:00.syllabus', 'scroll'),
(3, '2024-10-02 08:20:00.syllabus', 'log out'),
(3, '2024-10-02 10:00.syllabus:00.syllabus', 'log in'),
(3, '2024-10-02 10:15:00.syllabus', 'scroll'),
(3, '2024-10-02 10:45:00.syllabus', 'log out');