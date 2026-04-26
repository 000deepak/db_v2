
## Index
- Indexes support the efficient resolution of queries
- Indexes are special data structures, that store a small portion of the data set in an easy-to-traverse form. The index stores the value of a specific field or set of fields, ordered by the value of the field as specified in the index.

## create an index
- see createIndex()
- https://docs.mongodb.com/manual/indexes/#index-types
- old
- db.COLLECTION_NAME.ensureIndex({KEY:1})
- name of the field on which you want to create index
- 1 is for ascending order
- -1 is for descending order

```js
- db.myCollection1.stats();
-    "nindexes" : 1,
-    "totalIndexSize" : 36864,
-    "indexSizes" : {
-   "_id_" : 36864
-    },

- db.myCollection1.ensureIndex({"title":1}) - create index on 'title' field in ascending order
- {
-     "createdCollectionAutomatically" : false,
-     "numIndexesBefore" : 1,
-     "numIndexesAfter" : 2,
-     "ok" : 1.0
- }

- db.myCollection1.stats();
- 
-    "nindexes" : 2,
-    "totalIndexSize" : 53248,
-    "indexSizes" : {
-   "_id_" : 36864,
-   "title_1" : 16384                                     - ---- this is the index created with name of column ('title') and sort order (1)
-    },

- db.myCollection1.ensureIndex({"title":1,"description":-1})
- {
-     "createdCollectionAutomatically" : false,
-     "numIndexesBefore" : 2,
-     "numIndexesAfter" : 3,
-     "ok" : 1.0
- }
- db.myCollection1.stats();
```


## Indexes in MongoDB
Indexes in MongoDB are special data structures that store a small portion of the data set in a form that's easy to traverse. They are used to improve the speed of data retrieval operations on a database table at the cost of additional space and slower writes. Without indexes, MongoDB must perform a collection scan, i.e., scan every document in a collection, to select those that match the query statement.

## Index Creation Basics
- To create an index, you use the createIndex method. Here’s the basic syntax:
```javascript
db.collection.createIndex(keys, options)
keys: Specifies the field or fields to index and the index type. For example, { "field": 1 } creates an ascending index on field.
options: Specifies additional options like unique, sparse, and so on.

This creates an ascending index on the username field in the users collection.
db.users.createIndex({ "username": 1 })
```

## Dropping/Deleting an Index
- To delete an index, use the dropIndex method. Here’s the basic syntax:
```javascript
db.collection.dropIndex(index)

This drops the index named username_1.
index: The index to be dropped, specified by the index name or index specification document.
db.users.dropIndex("username_1")
```

## Sparse Indexes and Partial Indexes
- Sparse Indexes: Only index documents that contain the indexed field. If a document is missing the indexed field, it is not included in the index.
```javascript
db.collection.createIndex({ "field": 1 }, { sparse: true })
```
- Partial Indexes: Index only the documents that meet a specified filter expression.
```javascript
This index includes only the documents where field is greater than 10.
db.collection.createIndex({ "field": 1 }, { partialFilterExpression: { "field": { $gt: 10 } } })
```

## Get Indices of a Collection
- To list all indexes on a collection, use the getIndexes method:
```javascript
db.collection.getIndexes()

This returns an array of documents, each representing an index on the users collection.
db.users.getIndexes()
```

## Compound Index
- A compound index is an index on multiple fields. It supports queries that match multiple fields.
```javascript
This creates an ascending index on both lastName and firstName.
db.users.createIndex({ "lastName": 1, "firstName": 1 })
```

## Unique Index
- A unique index ensures that the indexed fields do not store duplicate values.
```javascript
This creates a unique index on the username field in the users collection.
db.users.createIndex({ "username": 1 }, { unique: true })
```

## Single Field Index
- A single field index is an index on a single field. It can be ascending or descending.
```javascript
This creates an ascending index on the age field in the users collection.
db.users.createIndex({ "age": 1 })
```

## Delete
- Deleting an index can be done using the dropIndex method as explained above. If you want to drop all indexes except the _id index, use the dropIndexes method:
```javascript
db.collection.dropIndexes()

This drops all indexes in the users collection except the default _id index.
db.users.dropIndexes()
```

## List
- To list all indexes on a collection, use the getIndexes method as mentioned earlier. It provides detailed information about each index, including the fields, type, and options used when creating the index.
```javascript
db.users.getIndexes()
This lists all indexes on the users collection.
```

## Example in Practice
```javascript
// Creating a single field index
db.users.createIndex({ "username": 1 })

// Creating a compound index
db.users.createIndex({ "lastName": 1, "firstName": 1 })

// Creating a unique index
db.users.createIndex({ "email": 1 }, { unique: true })

// Creating a sparse index
db.users.createIndex({ "nickname": 1 }, { sparse: true })

// Creating a partial index
db.orders.createIndex({ "price": 1 }, { partialFilterExpression: { "status": "active" } })

// Listing all indexes in the users collection
printjson(db.users.getIndexes())

// Dropping a specific index
db.users.dropIndex("username_1")

// Dropping all indexes in the users collection
db.users.dropIndexes()
This example shows how to create different types of indexes, list all indexes, and delete specific or all indexes in a collection.
```

| Parameter           | Type           | Description           |
|---------------------|----------------|-----------|
| background          | Boolean        | Builds the index in the background so that building an index does not block other database activities. Specify true to build in the background. The default value is false. |
| unique              | Boolean        | Creates a unique index so that the collection will not accept insertion of documents where the index key or keys match an existing value in the index. Specify true to create a unique index. The default value is false. |
| name                | string         | The name of the index. If unspecified, MongoDB generates an index name by concatenating the names of the indexed fields and the sort order.      |
| dropDups            | Boolean        | Creates a unique index on a field that may have duplicates. MongoDB indexes only the first occurrence of a key and removes all documents from the collection that contain subsequent occurrences of that key. Specify true to create unique index. The default value is false. |
| sparse              | Boolean        | If true, the index only references documents with the specified field. These indexes use less space but behave differently in some situations (particularly sorts). The default value is false.  |
| expireAfterSeconds  | integer        | Specifies a value, in seconds, as a TTL to control how long MongoDB retains documents in this collection.      |
| v                   | index version  | The index version number. The default index version depends on the version of MongoDB running when creating the index.   |
| weights             | document       | The weight is a number ranging from 1 to 99,999 and denotes the significance of the field relative to the other indexed fields in terms of the score.   |
| default_language    | string         | For a text index, the language that determines the list of stop words and the rules for the stemmer and tokenizer. The default value is english.    |
| language_override   | string         | For a text index, specify the name of the field in the document that contains the language to override the default language. The default value is language. |
