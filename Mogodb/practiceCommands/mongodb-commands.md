# MongoDB Commands

### Show All Databases
```js
show dbs
```

### Show Current Database
```js
db
```

### Create Or Switch Database
```js
use acme
```

### Drop
```js
db.dropDatabase()
```

### Create Collection
```js
db.createCollection('posts')
```

### Show Collections
```js
show collections
```
---
## Insert
- Insert a Single Document: insertOne()
  - The insertOne() method inserts a single document into the collection.
  - This inserts a new document into the users collection with the specified fields.
```js
db.collection.insertOne(document, options)
document: The document to insert into the collection.
options: Optional parameters like writeConcern.
```
- Insert Multiple Documents: insertMany()
```js
db.collection.insertMany(documents, options)
documents: An array of documents to insert into the collection.
options: Optional parameters like writeConcern.
```
### **Explanation of Write Concern in MongoDB vs. SQL Transactions**
- **MongoDB `writeConcern`**: Determines how many nodes must acknowledge the write before it's considered successful. Example:  
  - `{ w: 0 }` → No acknowledgment  
  - `{ w: 1 }` → Acknowledged by the primary node  
  - `{ w: "majority" }` → Acknowledged by most nodes in a replica set  
- **SQL Transaction Control (`COMMIT`, `ROLLBACK`)**: Ensures that data is written safely in relational databases, offering durability and rollback mechanisms.


### Insert Row
```js
db.posts.insert({
  title: 'Post One',
  body: 'Body of post one',
  category: 'News',
  tags: ['news', 'events'],
  user: {
    name: 'John Doe',
    status: 'author'
  },
  date: Date()
})
```

### Insert Multiple Rows

```js
db.posts.insertMany([
  {
    title: 'Post Two',
    body: 'Body of post two',
    category: 'Technology',
    date: Date()
  },
  {
    title: 'Post Three',
    body: 'Body of post three',
    category: 'News',
    date: Date()
  },
  {
    title: 'Post Four',
    body: 'Body of post three',
    category: 'Entertainment',
    date: Date()
  }
])
```

## Read
- syllabus
	- simple filter
 	- findOne()
  	- forEach()  
	- limit, skip, sort and count
	- AND, OR and IN Conditions
	- find() method with Projection
	- find() on Nested Data

### Get All Rows
```js
db.posts.find()
```

### Get All Rows Formatted
```js
db.find().pretty()
```

### Filter
```js
db.posts.find({ category: 'News' })
```

### Sort Rows
```js
db.posts.find().sort({ title: 1 }).pretty() //asc
db.posts.find().sort({ title: -1 }).pretty()//desc
```

### Count Rows
```js
db.posts.find().count()
db.posts.find({ category: 'news' }).count()
```

### Limit Rows
```js
db.posts.find().limit(2).pretty()
```

### Chaining
```js
db.posts.find().limit(2).sort({ title: 1 }).pretty()
```

### Foreach
```js
db.posts.find().forEach(function(doc) {
  print("Blog Post: " + doc.title)
})
```

### Find One Row
```js
db.posts.findOne({ category: 'News' })
```

### Projection : select specific fields from document(like selecting sepecific columns from table)
```js
db.posts.find({ title: 'Post One' }, {
  title: 1,
  author: 1
})
```

# `find()` on Nested Data
## 1. Querying Embedded Documents (Objects)

* Dot notation (`"address.city"`)
* Match entire embedded document

## 2. Querying Arrays
* Find array contains a value
* `$all`
* `$in`
* `$nin`
* `$size`

## 3. Querying Arrays of Embedded Documents
* Dot notation (`"projects.name"`)
* `$elemMatch`
* Dot notation vs `$elemMatch`

## 4. Field Existence & Type Queries
* `$exists`
* `$type`

## 5. Array Index & Projection
* Query by array index (`"skills.0"`)
* `$slice` (return part of an array)
  
---

```javascript
//sample document
{
    name: "John",

    address: {
        city: "Boston",
        state: "MA"
    },

    skills: ["Java", "Spring", "MongoDB"],

    projects: [
        { name: "Ecommerce", duration: 12 },
        { name: "Banking", duration: 8 }
    ]
}
```

## 1. Querying Objects (Embedded Documents)
1. Use **dot notation** to access fields inside an object.
```javascript
db.users.find({ "address.city": "Boston" })

//Finds documents where the nested field `address.city` is `"Boston"`.
//Note:** Field names containing `.` must be enclosed in quotes.
```

2. You can also match the **entire embedded document**:
```javascript
db.users.find({
    address: {
        city: "Boston",
        state: "MA"
    }
})

//This matches only if the whole object is exactly the same.
```

## 2. Querying Arrays
- MongoDB automatically checks whether an array contains a value.
```javascript
db.users.find({ skills: "Java" })

//Matches:
skills: ["Java", "Spring", "MongoDB"]
```

## 3. Array Operators
- `$all`
- Matches if an array contains **all** specified values.
```javascript
db.users.find({
    skills: {
        $all: ["Java", "Spring"]
    }
})
// Array must contain both values.
```
- `$in`
- Matches if an array contains **any** specified value.
```javascript
db.users.find({
    skills: {
        $in: ["Java", "Python"]
    }
})
//Java **OR** Python.
```
- `$size`
- Matches arrays having exactly the specified number of elements.
```javascript
db.users.find({
    skills: {
        $size: 3
    }
})
```
## 4. Arrays of Objects/Embedded Documents
```javascript
projects: [
    { name: "Ecommerce", duration: 12 },
    { name: "Banking", duration: 8 }
]

//Search using dot notation:
//Matches if **any object** has `name = Banking`.
db.users.find({
    "projects.name": "Banking"
})
```

## 5. `$elemMatch`
Used when **multiple conditions must match the same object** inside an array.
```javascript
db.users.find({
    projects: {
        $elemMatch: {
            name: "Banking",
            duration: 8
        }
    }
})
//Finds an object where both conditions are true.
```

## Dot Notation vs `$elemMatch`
Without `$elemMatch`
```javascript
db.users.find({
    "projects.name": "Banking",
    "projects.duration": 12
})

//This may match because:
[
    { name: "Banking", duration: 8 },
    { name: "Ecommerce", duration: 12 }
]

//MongoDB checks each condition independently.
//With `$elemMatch`

db.users.find({
    projects: {
        $elemMatch: {
            name: "Banking",
            duration: 12
        }
    }
})
//❌ No match, because no **single object** satisfies both conditions.
* **Dot notation** checks conditions independently across array elements.
* **`$elemMatch`** ensures all conditions match the **same array element**.
```

## 6. `$exists`
Checks whether a field exists.
```javascript
db.users.find({
    phone: { $exists: true }
})
```

| Query                                 | Purpose                              |
| ------------------------------------- | ------------------------------------ |
| `{ "address.city": "Boston" }`        | Find nested object field             |
| `{ skills: "Java" }`                  | Array contains value                 |
| `{ skills: { $all: [...] } }`         | Array contains all values            |
| `{ skills: { $in: [...] } }`          | Array contains any value             |
| `{ skills: { $size: 3 } }`            | Array has fixed size                 |
| `{ "projects.name": "Banking" }`      | Search inside array of objects       |
| `{ projects: { $elemMatch: {...} } }` | Same object satisfies all conditions |
| `{ phone: { $exists: true } }`        | Check if field exists                |


# Update Row

```js
db.posts.update({ title: 'Post Two' },
{
  title: 'Post Two',
  body: 'New body for post 2',
  date: Date()
},
{
  upsert: true
})
```

### Update Specific Field

```js
db.posts.update({ title: 'Post Two' },
{
  $set: {
    body: 'Body for post 2',
    category: 'Technology'
  }
})
```

### Increment Field (\$inc)

```js
db.posts.update({ title: 'Post Two' },
{
  $inc: {
    likes: 5
  }
})
```

### Rename Field

```js
db.posts.update({ title: 'Post Two' },
{
  $rename: {
    likes: 'views'
  }
})
```

### Delete Row

```js
db.posts.remove({ title: 'Post Four' })
```

### Sub-Documents

```js
db.posts.update({ title: 'Post One' },
{
  $set: {
    comments: [
      {
        body: 'Comment One',
        user: 'Mary Williams',
        date: Date()
      },
      {
        body: 'Comment Two',
        user: 'Harry White',
        date: Date()
      }
    ]
  }
})
```

### Find By Element in Array (\$elemMatch)

```js
db.posts.find({
  comments: {
     $elemMatch: {
       user: 'Mary Williams'
       }
    }
  }
)
```

### Add Index

```js
db.posts.createIndex({ title: 'text' })
```

### Text Search

```js
db.posts.find({
  $text: {
    $search: "\"Post O\""
    }
})
```

### Greater & Less Than

```js
db.posts.find({ views: { $gt: 2 } })
db.posts.find({ views: { $gte: 7 } })
db.posts.find({ views: { $lt: 7 } })
db.posts.find({ views: { $lte: 7 } })
```

### List of the indexes in a collection

```js
db.restaurants.getIndexes()
[
	{
		"v" : 2,
		"key" : {
			"_id" : 1
		},
		"name" : "_id_",
		"ns" : "test.restaurants"
	},
	{
		"v" : 2,
		"key" : {
			"borough" : 1
		},
		"name" : "borough_1",
		"ns" : "test.restaurants"
	}
]
```

### Drop an existing index

```js
db.restaurants.dropIndex("cuisine_1_grades.score_1")
{ "nIndexesWas" : 4, "ok" : 1 }
```

### CreateView
Syntax
```js
db.createView(<view>, <source>, <pipeline>, <options>)
```

Example
```js
db.createView('postsTitles', 'posts',[{$project:{title:1}}]);
{ "ok" : 1 }


db.postsTitles.find();
```




<div align="right">
    <b><a href="#">↥ back to top</a></b>
</div>

