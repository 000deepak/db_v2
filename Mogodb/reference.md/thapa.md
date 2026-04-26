# COURSE TOPICS

## MONGODB

### BASICS
- Introduction to MongoDB
- NoSQL Vs SQL
- JSON Vs BSON
- Managing DB & Collections
- Advanced CRUD Operations
- Comparison Operators
- Cursors in MongoDB
- Logical Operators
- $expr & Elements Operator
- Projection & Relationship
- Embedded Documents

### ADVANCED
- Introduction to Indexes
- Creating and Managing Index
- Understanding the Aggregation Framework
  - Introduction to Aggregation
  - Basic Aggregation Operations
  - Combining Aggregation Stages
  - Aggregation Operators and Expressions
  - Pipeline Stages ($match, $project, $group, $sort, $limit, $unwind, $filter, $skip, etc.)

# Introduction to MongoDB

## What is MongoDB?
MongoDB is an open-source, document-oriented NoSQL database management system. Designed for flexibility, scalability, and performance in handling unstructured or semi-structured data.

### More About MongoDB
It was created by a company called 10gen, which is now known as MongoDB, Inc. The company was founded by Eliot Horowitz and Dwight Merriman in 2007. The first version of MongoDB was released in 2009.

### Clusters in MongoDB
In MongoDB, a cluster refers to a group of interconnected servers (nodes) that work together to store and manage data.

### More About MongoDB
**HUMONGOUS**  
**HU MONGO US**

## Importing JSON in MongoDB

```shell
mongoimport jsonfile.json –d database_name –c collection_name
mongoimport products.json -d shop -c products
mongoimport products.json -d shop -c products --jsonArray
```

Here, `--jsonArray` accepts the import of data expressed with multiple MongoDB documents within a single JSON array. Limited to imports of 16 MB or smaller.

---

# SQL vs MongoDB (NoSQL)

## SQL
- **SQL databases** are relational databases.
- They use structured tables to store data in rows and columns.
- Suitable for applications with well-defined schemas and fixed data structures.
- **Examples**: E-commerce Platforms, HR Management
  - MySQL, PostgreSQL, Oracle.

## NoSQL
- **NoSQL databases** are non-relational databases.
- They provide flexibility in data storage, allowing varied data types and structures.
- Ideal for applications with dynamic or evolving data models.
- **Examples**: CMS, Social Media Platforms, Gaming
  - MongoDB, Cassandra, Redis.

### SQL Example
#### Table: Students

| student_id | first_name | last_name | age | grade |
|------------|------------|-----------|-----|-------|
| 1          | Vinod      | Thapa     | 16  | 11    |
| 2          | Thapa      | Technical | 17  | 12    |

#### Table: Subjects

| subject_id | subject_name |
|------------|--------------|
| 1          | Mathematics  |
| 2          | Computer     |

#### Table: Grades

| student_id | subject_id | marks |
|------------|------------|-------|
| 1          | 1          | 100   |
| 2          | 2          | 99    |

### NoSQL Example (MongoDB)
```json
[
  {
    "_id": "1",
    "first_name": "Vinod",
    "last_name": "Thapa",
    "age": 16,
    "grade": 11,
    "subjects": [
      { "subject_name": "Mathematics", "marks": 100 },
      { "subject_name": "Computer", "marks": 100 }
    ]
  },
  {
    "_id": "2",
    "first_name": "Thapa",
    "last_name": "Technical",
    "age": 17,
    "grade": 12,
    "extra": "sport captain",
    "subjects": [
      { "subject_name": "Mathematics", "marks": 100 },
      { "subject_name": "Computer", "marks": 100 }
    ]
  }
]
```

## MongoDB Terminologies

### Database
- Collections:
  - Students
  - Teachers
  - Products

### Schemaless

#### Document Examples
```json
{
  "name": "Vinod",
  "age": 30,
  "address": {
    "city": "New York"
  }
}


{
  "name": "Thapa",
  "age": 30,
  "address": {
    "city": "Pokhara"
  }
}


{
  "name": "Binamra",
  "address": {
    "city": "Kathmandu"
  }
}


{
  "name": "Mobile",
  "stock": 30
}


{
  "name": "Laptop",
  "stock": 10,
  "comments": {
    "user1": "Nice"
  }
}
```

# Key Features of MongoDB

## Flexible Schema Design
- MongoDB allows dynamic, schema-less data structures.
- Easily accommodate changing data requirements.

## Scalability and Performance
- Horizontal scaling supports large datasets and high traffic.
- Optimized read and write operations for fast performance.

## Document-Oriented Storage
- Data is stored in flexible, JSON-like BSON documents.
- Self-contained units with rich data types and nested arrays.

## Dynamic Queries
- Rich query language with support for complex queries.
- Utilize indexes to speed up query execution.

## Aggregation Framework
- Perform advanced data transformations and analysis.
- Process data using multiple pipeline stages.

## Open Source and Community
- MongoDB is open-source with a vibrant community.
- Regular updates, improvements, and support.




## Managing Databases in MongoDB

- Creating / Deleting Databases
- Creating / Deleting Collections

## Managing Databases and Collections

```shell
show dbs;

use <database-name>;

db.dropDatabase();

show collections;

db.createCollection('<collection-name>');

db.<collection-name>.drop();
```







# Update Operations in MongoDB
- updateOne() and updateMany()
- Removing and renaming fields
- Adding, removing items from array
- Updating embedded documents
- updateOne() and updateMany()

```javascript
db.collectionName.updateOne(
  { filter },
  { $set: { existingField: newValue, newField: "new value", /* ... */ } }
);

db.collectionName.updateMany(
  { filter },
  { $set: { existingField: newValue, /* ... */ } }
);
```

## Removing and Renaming Fields
```javascript
db.collectionName.updateOne({ filter }, { $unset: { fieldName: 1 } });

db.collectionName.updateOne(
  { filter },
  { $rename: { oldFieldName: "newFieldName" } }
);
```

## Updating Arrays and Embedded Documents
```javascript
db.collectionName.updateOne(
  { filter },
  { $push: { arrayField: "new element" } }
);

db.collectionName.updateOne(
  { filter },
  { $pop: { arrayField: value } }
);

db.collectionName.updateOne(
  { filter },
  { $set: { "arrayField.$.text": "Updated text" } }
);
```

## Delete Operations in MongoDB
```javascript
db.collectionName.deleteOne({ filter });

db.sales.deleteMany({ price: 55 });
```

## MONGOD DELETEONE
### Before
```json
[
  {
    "name": "Vinod",
    "age": 29
  },
  {
    "name": "Binamra",
    "age": 20
  }
]
```

### DeleteOne
```javascript
db.Students.deleteOne({
  name: "Binamra"
});
```

### After
```json
[
  {
    "name": "Vinod",
    "age": 29
  }
]
```

## Indexes in MongoDB
### What are Indexes?
Indexes are specialized data structures that optimize data retrieval speed in MongoDB. They store a fraction of data in a more searchable format, enabling MongoDB to locate data faster during queries. Indexes are separate from collections, and multiple indexes can exist per collection.

### Benefits of Indexes
Indexes provide several benefits:
- Faster query performance
- Efficient data retrieval
- Support for sorting and aggregation
- Can enforce uniqueness
- Enable text search capabilities

### Managing Indexes
In MongoDB, indexes can be managed using commands like `createIndex`, `dropIndex`, and `listIndexes`. Proper management ensures optimal query performance and storage efficiency.

### Types of Indexes
MongoDB supports various types of indexes:
- **Unique Index:** Ensures that the indexed field has unique values across the collection.
- **Text Index:** Enables text search capabilities on string content.
- **Compound Index:** Indexes multiple fields together to support queries that match on multiple fields.

### When Not to Use Indexes?
While indexes improve query performance, they also come with overhead:
- **Small Collections:** In small collections or databases with limited data, indexes may not provide significant benefits and can consume unnecessary resources.
- **Frequent Write Operations:** Indexes can slow down write operations (inserts, updates, deletes) as they need to be updated whenever the indexed fields change.
- **Unnecessary Queries:** If certain queries are seldom executed or are not critical to performance, indexing them may not be necessary.

Consider the trade-offs between query performance improvements and resource utilization before adding indexes.


## Benefits of Indexes
- **Faster Querying:** Indexes drastically accelerate data retrieval, particularly for large collections.
- **Efficient Sorting:** Indexes facilitate rapid sorting based on specific fields.
- **Improved Aggregation:** Aggregation operations become more efficient with optimized indexes.
- **Indexing on Multiple Fields:** Complex queries can be executed efficiently by utilizing multiple fields in indexes.

## explain()

Use the `explain()` method to understand query execution in detail.

```javascript
db.products.find({ name: 'Air Fryer' }).explain();

db.products.find({ name: 'Air Fryer' }).explain("executionStats");
```

Use it to measure the time taken to execute a query.


## Managing Indexes
```js
db.products.createIndex({ field: 1 });

(1) for storing indexes in ascending order.

(-1) for storing indexes in descending order.

db.collection.getIndexes();

_id is a default index.

db.collection.dropIndex({ field: 1 });

db.collection.dropIndex(“index_name”);

```

## Unique and Text Indexes
```js
db.collection.createIndex({ field: 1 }, { unique: true });

db.collection.createIndex({ field: "text" });

db.collection.find({ $text: { $search: "keyword" } });

Searching using index is faster than   $regex searching.

db.products.find({ field: { $regex: "air" } })
```

## When not to use Indexes?
### Indexes on Rarely Used Fields
- Indexing fields that are seldom used in queries can consume unnecessary space and resources.

### Balancing Act
- Indexing requires disk space and memory. Overindexing can lead to resource strain and impact overall performance.

### Indexing Small Collections
- In smaller collections, the cost of index maintenance might outweigh the benefits gained from querying.


# Aggregation in MongoDB
### What is Aggregation?
**Definition:** Aggregation is the process of performing transformations on documents and combining them to produce computed results.
**Pipeline Stages:** Aggregations consist of multiple pipeline stages, each performing a specific operation on the input data.

### Benefits
- **Aggregating Data:** Complex calculations and operations are possible.
- **Advanced Transformations:** Data can be combined, reshaped, and computed for insights.
- **Efficient Processing:** Aggregation handles large datasets efficiently.

### $match
```js
The $match stage is similar to the query used as the first argument in .find(). It filters 
documents based on
specified conditions.
Syntax
{ $match: { <query> } }
Example
db.products.aggregate([
{ $match: { company: "64c23350e32f4a51b19b9235" } }
]);
```

### $group
```js
The $group stage groups documents by specified fields and performs aggregate operations on grouped 
data
{
$group:
{
_id: <expression>, // Group key
<field1>: { <accumulator1> : <expression1> },
}
}

db.products.aggregate([
{ $group: { _id: { comp: "$company" }, totalProducts: { $sum: 1 } } }
]);
This groups products by company and calculates the total number of products for each company.
The $group stage can calculate various aggregate values within grouped data.
db.products.aggregate([
{ $group: {
_id: { comp: "$company" },
totalPrice: { $sum: "$price" },
totalProducts: { $sum: 1 },
averagePrice:     { $avg: "$price" }
}}
]);
```

### $sort
```js
{ $sort: { <field>: <order> } }
db.products.aggregate([
{ $sort: { totalProducts: 1 } }
]);
```

### $project
```js
The $project stage reshapes documents, includes or excludes fields, and performs operations on 
fields.
{ $project: { <field1>: <expression1>, ... } }
db.products.aggregate([
{ $project: { name: 1, discountedPrice: { $subtract: ["$price", 5] } } }
]);
Projects the name field and calculates a discountedPrice field by subtracting 5 from the price.
$sum, $subtract, $multiply, $avg, etc. are types of expression operator.
```

### $push
```js
The $push stage adds elements to an array field within documents.
{ $push: <expression> }
db.products.aggregate([
{ $group: { _id: { company: "$company" }, products: { $push: "$name" } } }
]);
```

### $unwind
```js
The $unwind stage deconstructs an array field and produces multiple documents.
{ $unwind: <array> }
db.products.aggregate([
{ $unwind: "$colors" },
{ $group: { _id: { company: "$company" }, products: { $push: "$colors" } } }
]);
Deconstructs the colors array field, groups products by company, and creates an array of colors for 
each
company.
```

### $addToSet
```js
The $addToSet stage adds elements to an array field while preventing duplicates.
db.products.aggregate([
{ $unwind: "$colors" },
{ $group: {
_id: { company: "$company" },
products: { $addToSet: "$colors" }
} }
])
Groups products by company and creates an array of unique colors for each company.
```

### $size
```js
The $size stage calculates the length of an array field.
{ $size: <array> }
db.products.aggregate([
{ $project: { name: 1, numberOfColors: { $size: "$colors" } } }
]);
Projects the name field and calculates the number of colors in the colors array.
```

### $limit and $skip
```js
The $limit and $skip stages are useful for pagination, limiting, and skipping results.
{   $limit: <positive integer> }
db.products.aggregate([
{ $skip: 10 },
{ $limit: 10 }
]);
```

### $filter
```js
The $filter stage filters elements of an array based on specified conditions.

$project: {
  <field>: {
    $filter: {
      input: '$<array>’,
      as: '<variable>’
      cond: <expression>
    }
  }
}
```
                         
### $addFields
```js
The $addFields stage adds new fields to documents in a cleaner way compared to $project.
{ $addFields: { <field1>: <expression1>, ... } }
db.products.aggregate([
{ $addFields: { discountedPrice: { $subtract: ["$price", 5] } } }
]);

```

## Introduction to MongoDB Atlas
MongoDB Atlas is MongoDB's fully managed cloud database service. It offers an easy way to deploy, manage, and scale MongoDB databases in the cloud. Atlas eliminates the need for manual setup and maintenance, allowing developers to focus on their applications. It provides automated scaling options to accommodate growing workloads. Atlas supports global clusters, enabling databases to be deployed across multiple regions for better data availability and reduced latency.

## Working with MongoDB Compass
MongoDB Compass is a graphical user interface (GUI) for MongoDB. It provides a visual way to explore and interact with MongoDB databases, making it easier to view data, run queries, and perform administrative tasks.

## Working with MongoDB Drivers
### Introduction to MongoDB Drivers
- MongoDB drivers are software libraries that allow applications to interact with MongoDB databases. MongoDB offers official and community-supported drivers for various programming languages. Drivers provide APIs tailored to specific programming languages.

### Working with Node.js MongoDB Drivers
- For Node.js applications, MongoDB offers an official driver that provides a native Node.js interface to MongoDB. It allows Node.js developers to connect to MongoDB, execute queries, and manage data using JavaScript.
- For more detailed information about MongoDB drivers, refer to the [MongoDB Drivers Documentation](https://www.mongodb.com/docs/drivers/).


## Getting Started with Node.js MongoDB Driver
MongoDB Node.js Driver is a direct interface to MongoDB, providing a native way to interact with MongoDB databases from Node.js applications.

### Why Mongoose instead of the official driver?
Mongoose is an Object Data Modeling (ODM) library for MongoDB and Node.js, offering several advantages over the official MongoDB driver:

- **Structured Schemas**:
  - Mongoose allows you to define your data's structure using schemas, making it easier to understand your database structure and work with it.

- **Validation**:
  - Mongoose provides built-in validation to ensure data validity before saving it to the database.

- **Relationships**:
  - MongoDB doesn’t inherently support relationships, but Mongoose helps replicate relationships (like one-to-one, one-to-many) in MongoDB and facilitates relating schemas with each other easily.

- **Middleware**:
  - Mongoose offers middleware functions that can be executed before or after certain operations, providing flexibility and allowing custom logic to be applied.

- **Complex Queries**:
  - While MongoDB itself supports complex queries and aggregations, Mongoose simplifies their syntax and provides a more organized way to work with them.

Mongoose enhances MongoDB interaction by providing a structured, schema-based approach, validation, support for relationships, middleware capabilities, and simplification of complex queries. This makes it particularly suitable for applications that require a more organized data modeling approach and additional features beyond basic CRUD operations.
