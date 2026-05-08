
## Section 11: Design Instagram Database Clone
**1. Things to consider**
1. Photos
2. Users
3. Likes
4. Hashtags
5. Comments
6. Followers
7. Followees
etc ...

**2. Implement the instagram clone**
```sql
-- create the database
CREATE DATABASE ig_clone;
USE ig_clone;

-- user table
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- photos table
CREATE TABLE photos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  image_url VARCHAR(255) NOT NULL,
  user_id INT NOT NULL, -- point to users table
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

-- comments table
CREATE TABLE comments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  comment_text VARCHAR(255) NOT NULL,
  user_id INT NOT NULL, -- point to users table
  photo_id INT NOT NULL, -- point to photos table
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(photo_id) REFERENCES photos(id)
);

-- likes table
CREATE TABLE likes (
  user_id INT NOT NULL,
  photo_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  PRIMARY KEY(user_id, photo_id) -- prevent duplications
);

-- follows table
CREATE TABLE follows (
  follower_id INT NOT NULL,
  followee_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(follower_id) REFERENCES users(id),
  FOREIGN KEY(followee_id) REFERENCES users(id),
  PRIMARY KEY(follower_id, followee_id) -- prevent duplications
);

-- tags table
CREATE TABLE tags (
  id INT AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

-- photo_tags table
CREATE TABLE photo_tags (
  photo_id INT NOT NULL,
  tag_id INT NOT NULL,
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  FOREIGN KEY(tag_id) REFERENCES tags(id),
  PRIMARY KEY(photo_id, tag_id)
);
```

## Section 12: Working with instagram data
**1. Load the data**
see the ig_clone_data.sql file and load it
```sql
source ig_clone_data.sql
```

**2. Playing with data**
1. Find the top 5 oldest users
```sql
SELECT
  username, 
  created_at
FROM users
ORDER BY created_at
LIMIT 5;
```

2. Find the top 3 most popular registration day of a week
```sql
SELECT
  username, 
  DAYNAME(created_at) AS day,
  COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 3;
```

3. Find the inactive users who have never post a photo on instagram
```sql
SELECT username
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;
```

4. Find the most liked photo user
```sql
SELECT 
  username,
  photos.id,
  photos.image_url, 
  COUNT(*) AS total
FROM photos
INNER JOIN likes
  ON likes.photo_id = photos.id
INNER JOIN users
  ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
```

5. Find the average posts a user make
total photos / total users
```sql
SELECT 
  (SELECT COUNT(*) FROM photos) /
  (SELECT COUNT(*) FROM users) 
  AS avg_post;
```

6. Find the top 5 popular hashtag
```sql
SELECT tags.tag_name AS tag, 
  COUNT(*) AS total 
FROM photo_tags 
JOIN tags 
  ON photo_tags.tag_id = tags.id 
GROUP BY tags.id 
ORDER BY total DESC 
LIMIT 5; 
```

7. Find users who have liked every single photo on a site
```sql
SELECT username, 
  COUNT(*) AS num_likes 
FROM users 
INNER JOIN likes 
  ON users.id = likes.user_id 
GROUP BY likes.user_id 
HAVING num_likes = (SELECT COUNT(*) 
  FROM photos); 
```

## Section 13: NodeJS with MySQL
**1. Install MySQL Node Package**
`npm install mysql`

**2. Connect to Database**
```javascript
var mysql = require('mysql');

// establish a connection with database
var connection = mysql.createConnection({
  host : 'localhost',
  user : 'database user name here',
  database : 'database name here'
});
```

**3. Run Queries**
```javascript
connection.query('SELECT 1 + 1 AS solution', function (error, results, fields) {
   if (error) throw error;
   console.log('The solution is: ', results[0].solution);
});

var q = 'SELECT CURTIME() as time, CURDATE() as date, NOW() as now';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results[0].time);
  console.log(results[0].date);
  console.log(results[0].now);
});
```

**4. Create an users table for NodeJS**
```sql
CREATE TABLE users (
  email VARCHAR(255) PRIMARY KEY,
  created_at TIMESTAMP DEFAULT NOW()
);
```

**5. Insert users (from mysql command line)**
```sql
INSERT INTO users (email) VALUES('Katie34@yahoo.com'), ('Tunde@gmail.com');
```

**6. SELECT Users from database through NodeJS**
```javascript
// select all users
var q = 'SELECT * FROM users ';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results);
});

// count total users
var q = 'SELECT COUNT(*) AS total FROM users ';
connection.query(q, function (error, results, fields) {
  if (error) throw error;
  console.log(results[0].total);
});
```

**7. INSERT users to database though NodeJS**
```javascript
// used faker npm package for generating fake user info
var person = {
    email: faker.internet.email(),
    created_at: faker.date.past()
};
 
var end_result = connection.query('INSERT INTO users SET ?', person, function(err, result) {
  if (err) throw err;
  console.log(result);
});

// insert 500 faker users into database
var data = [];
for(var i = 0; i < 500; i++){
  data.push([
    faker.internet.email(),
    faker.date.past()
  ]);
}
 
var q = 'INSERT INTO users (email, created_at) VALUES ?';
 
connection.query(q, [data], function(err, result) {
  console.log(err);
  console.log(result);
});
 
connection.end();
```

**8. Solving problem with MySQL**
```sql
-- find earliest user
SELECT 
  DATE_FORMAT(MIN(created_at), "%M %D %Y") as earliest_date 
FROM users;

-- find earliest user's email
SELECT * 
FROM users 
WHERE created_at = (SELECT Min(created_at) FROM users); 

-- find popular registration month
SELECT Monthname(created_at) AS month, 
       COUNT(*) AS count 
FROM users 
GROUP BY month 
ORDER BY count DESC;

-- count users' registraion email host
SELECT 
  CASE 
    WHEN email LIKE '%@gmail.com' THEN 'gmail' 
    WHEN email LIKE '%@yahoo.com' THEN 'yahoo' 
    WHEN email LIKE '%@hotmail.com' THEN 'hotmail' 
    ELSE 'other' 
  END AS provider, 
  COUNT(*) AS total_users 
FROM users 
GROUP BY provider 
ORDER BY total_users DESC; 
```
