syllabus : https://roadmap.sh/mongodb

# MongoDB Course Content
- Getting started with MongoDB
- Execution of a JavaScript file in MongoDB
- Making the output of find readable in shell
- Complementary Terms
- Installation
- Basic commands on mongo shell
- Hello World
- CRUD Operation
  - Create
  - Update
  - Delete
  - Read
  - Update of embedded documents
  - More update operators
  - “multi” Parameter while updating multiple documents

## db  
- Getting database information
- List all databases

## collection
- List all collections in the database
- Create a Collection
- Drop Collection

## read
- Querying for Data (Getting Started)
  - Find()
  - FindOne()
  - Limit, skip, sort, and count the results of the find() method
- Query Document – Using AND, OR, and IN Conditions
- find() method with Projection

## update
- Update Operators
  - $set operator to update specified field(s) in document(s)
- Upserts and Inserts
  - Insert a document

## Aggregation
- Count
- Sum
- Average
- Operations with arrays
- Aggregate query examples useful for work and learning
- Match
- Get sample data
- Remove docs that have a duplicate field in a collection (dedupe)
- Left Outer Join with aggregation ($Lookup)

## Server Aggregation
- Aggregation in a Server Method

## Indexes
- Index Creation Basics
- Dropping/Deleting an Index
- Sparse indexes and Partial indexes
- Get Indices of a Collection
- Compound
- Unique Index
- Single field
- Delete
- List

## Bulk Operations
- Converting a field to another type and updating the entire collection in Bulk



## section 2  
- 2dsphere Index
  - Create a 2dsphere Index
- Pluggable Storage Engines
  - WiredTiger
  - MMAP
  - In-memory
  - mongo-rocks
  - Fusion-io
  - TokuMX
- Java Driver
  - Fetch Collection data with condition
  - Create a database user
  - Create a tailable cursor
- Python Driver
  - Connect to MongoDB using pymongo
  - PyMongo queries
  - Update all documents in a collection using PyMongo
- Mongo as Shards
  - Sharding Environment Setup
- Replication
  - Basic configuration with three nodes
  - MongoDB as a Replica Set
  - Check MongoDB Replica Set states
  - Configure a ReplicaSet to support TLS/SSL
  - How to connect your Client (Mongo Shell) to a ReplicaSet?
- Authentication Mechanisms in MongoDB
  - Authentication Mechanisms
  - MongoDB Authorization Model
  - Built-in Roles
- Configuration
  - Starting mongo with a specific config file
- Backing up and Restoring Data
  - Basic mongodump of local default mongod instance
  - Basic mongorestore of local default mongod dump
  - mongoimport with JSON
  - mongoimport with CSV
