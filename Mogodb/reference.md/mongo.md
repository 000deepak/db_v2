## datatypes
- String 
	- This is the most commonly used datatype to store the data. String in MongoDB must be UTF-8 valid.
- Integer 
	- This type is used to store a numerical value. Integer can be 32 bit or 64 bit depending upon your server.
- Boolean 
	- This type is used to store a boolean (true/ false) value.
- Double 
	- This type is used to store floating point values.
- Min/ Max keys 
	- This type is used to compare a value against the lowest and highest BSON elements.
- Arrays 
	- This type is used to store arrays or list or multiple values into one key.
- Timestamp 
	- ctimestamp. This can be handy for recording when a document has been modified or added.
- Object 
	- This datatype is used for embedded documents.
- Null 
	- This type is used to store a Null value.
- Symbol 
	- This datatype is used identically to a string; however, it's generally reserved for languages that use a specific symbol type.
- Date 
	- This datatype is used to store the current date or time in UNIX time format. You can specify your own date time by creating object of Date and passing day, month, year into it.
- Object ID 
	- This datatype is used to store the document’s ID.
- Binary data 
	- This datatype is used to store binary data.
- Code 
	- This datatype is used to store JavaScript code into the document.
- Regular expression 
	- This datatype is used to store regular expression.

# MongoDB Structure
- **Database** (like SQL databases)
- **Collections** (like SQL tables)
  - **Documents** (like SQL rows)
- **Views** (like SQL views)
- **Transactions** (commit/abort)
- **Package**
  - **Stored Procedures** (*store proc*)
  - **Functions**
- Constraints on Fields
- Trigger
- Index
- Cursors

## Users
- Grant access to DB
- Grant access to DB/Collection
- Grant roles
- Grant permission to DB
- Grant permission to DB/Collection




## db        
- always means currently selected db
- list all databases
```shell
show dbs
```
- use the 'myDatabase1' database
```shell
use myDatabase1
```

## collections/ tables
```js
- db.createCollection("myCollection1")
- db.createCollection(name, options); 
//- options about memory size and indexing

- db.createCollection("myCollection1", { capped : true, autoIndexId : true, size : 6142800, max : 10000 } )

//Limiting a CAPPED collection to 2 MB
//that is, older documents are deleted when collection exceeds 2 MB data
db.createCollection(’logs’, {capped: true, size: 2097152})
```

| Field       | Type    | Description            |
|-------------|---------|---------------------------------------|
| capped      | Boolean | (Optional) If true, enables a capped collection. Capped collection is a fixed size collection that automatically overwrites its oldest entries when it reaches its maximum size. If you specify true, you need to specify size parameter also. |
| autoIndexId | Boolean | (Optional) If true, automatically create index on `_id` field. Default value is false.                                                                            |
| size        | number  | (Optional) Specifies a maximum size in bytes for a capped collection. If `capped` is true, then you need to specify this field also.                              |
| max         | number  | (Optional) Specifies the maximum number of documents allowed in the capped collection.                                                                            |

```js
//to get what all commands exists for 'myCollection1' collection
db.myCollection1.help();

//show all collections of 'myDatabase1' database
show collections

db.getCollectionNames();

db.getCollection('myCollection1');


//show all documents of 'myCollection1' collection
db.myCollection1.find()
db.getCollection('myCollection1').find({})

//find all
dbo.collection("customers")    
.find(query, projection)    
.limit(limit)    
.toArray(function(err, result) {
 	if (err) throw err;
	console.log(result);
	db.close();
});

//find one
dbo.collection("customers")    
.findOne(query, projection)    
.limit(limit)    
.toArray(function(err, result) {
 	if (err) throw err;
 	console.log(result);
 	db.close();
});


//keys
Object.keys(db.myCollection1.findOne());

//values
db.myCollection1.find().forEach(function(doc) {
	for (field in doc) {
		print(doc[field]);
	}
});

//print documents pretty
db.myCollection1.find().pretty()

//same as above
db.myCollection1.find().forEach(function(doc) {
	printjson(doc);
});	
```

## insert 
```js
// creates collection automatically, when you insert some document.
db.myCollection1.insert({"name" : "myCollection1"})  

// insert at least one document
db.myCollection1.insert({"name":"author 1"})  
db.myCollection1.insert({"title":"author 1 1"})
db.myCollection1.insert({"title":"author 1 2"})
db.myCollection1.insert({"title":"author 1 3"})

db.myCollection1.insert({
	firstName: "fn1",
	lastName: "ln1"
})

db.myCollection1.find().pretty();

db.myCollection1.insert(
	[
		{
			firstName: "fn3",
			lastName: "ln3"
		},
		{
			firstName: "fn2",
			lastName: "ln2",
			gender: "male"
		}
	]
)
```

## BulkWriteResults
- this object encapsulates the result of a bulk write operation, which can include multiple operations like inserts, updates, deletes, or a combination of these.
```js
    // Define an array of documents to insert
    const documents = [
      { name: 'Alice', age: 30 },
      { name: 'Bob', age: 25 },
      { name: 'Charlie', age: 35 }
    ];

    // Perform the bulk write operation
    const bulkWriteResult = await collection.bulkWrite([
      { insertOne: { document: documents[0] } },
      { insertOne: { document: documents[1] } },
      { insertOne: { document: documents[2] } }
    ]);
db.myCollection1.find().pretty();
```

## update for  update full/part feilds
- update 
	- replace				
		- match1 
		- way1 
		- overwrite doc 
		- `must give all existing field + new field`
```js
db.myCollection1.update(
	{firstName: "fn1"},
	{firstName: "fn1", lastName:"hello"}
);
```

- update 
	- replace multiple fields	
	- match1 
	- way1 
	- overwrite doc 
	- `must give all existing field + new field`
```js	
db.myCollection1.update(
{firstName: "fn1"},
{firstName: "fn1", lastName:"hello", gender:"male"}
);
```

- update 
	- set (insert key)					
	- match1 
	- way2 
	- add/modify field 
	- $set: {} 
	- `give only insert field`
```js	
db.myCollection1.update(
{firstName: "fn1"},
{$set: {score:44}}
);
```

- update 
	- set (update key)
```js		
db.myCollection1.update(
{firstName: "fn1"},
{$set: {score:5}}
);
```

- update 
	- inc (increment key)		
	- increment by 5 
	- `give updated only field(s)`
```js		
db.myCollection1.update(
{firstName: "fn1"},
{$inc: {score:5}}
);
```

- update 
	- unset (remove key)		
	- match1 
	- remove field 
	- $unset: {} 
	- `give only new field`
```js		
db.myCollection1.update(
{firstName: "fn1"},
{$unset: {score:1}}
);
```

- update 
	- unset (remove key) 
	- same as above
```js	
db.myCollection1.update(
{firstName: "fn1"},
{$unset: {score:0}}
);
```

- update 
	- insert/update 
	- upsert
```js	
db.myCollection1.update(
{firstName: "fn1"},
{firstName: "fn1", lastName: "lnnn"},
{upsert: true}
);
```

- update 
	- rename
```js	
db.myCollection1.update(
{firstName: "fn1"},
{$rename: {score: score2}}
);

db.myCollection1.update({'_id':ObjectId("598aea8feb8b4de45c012fc8")},{$set:{'title':'New MongoDB Tutorial'}})

db.myCollection1.update(
{'firstName':'fn1'},
{$set:{'title':'New MongoDB Tutorial'}},
{multi:true}        //- to update multiple documents, set a parameter 'multi' to true
)
```

- replace
```js	
db.myCollection1.save(
 	{
 	  "_id" : ObjectId("598aea8feb8b4de45c012fc8"),
 	   "title":"11 author 1 New Topic",
 		 "by":"author 1"
 	}
)
```

- remove all document of something
```js	
 db.myCollection1.remove(
 {firstName: "fn1"}
);
```

- remove 1st document
```js	
db.myCollection1.remove(
{firstName: "fn1"},
{justOne: true}
);

- db.myCollection1.remove(ObjectId("598aea8feb8b4de45c012fc8"))
- db.myCollection1.remove({'title':'NoSQL Database'})

//- delete only the first record
- db.myCollection1.remove({'title':'New MongoDB Tutorial 2'}, 1) 

//Remove All Documents from a Collection
- db.myCollection1.remove({}); 

//remove all
- db.myCollection1.remove({}); 
```

## find

```js
- db.collection.find(query, projection)
db.myCollection1.find() 
//- print all

- db.myCollection1.find({});

- db.myCollection1.find({},{"title":1})           
//- _id field is displayed, even without selecting it with 1

- db.myCollection1.find({},{_id:0, "title":1})    
//- _id field is now not displayed

- db.myCollection1.find({"title" : "MongoDB Overview"})
- db.myCollection1.find({"title" : "MongoDB Overview"}).pretty()
- db.myCollection1.find({"likes":{$gte:20}}).pretty()
- db.myCollection1.find({"likes":{$gt:20}}).pretty()
- db.myCollection1.find({"by": "title1"}).pretty()	

db.myCollection1.find({},{"title":1,_id:0}).limit(2)            
//- limit to 1st 2 documents

db.myCollection1.find({},{"title":1,_id:0}).limit(2).skip(0)    
//- limit to 2, dont skip any - same as above - default value in skip() method is 0

db.myCollection1.find({},{"title":1,_id:0}).limit(1).skip(1)    
//- limit to 1, after skipping 1 - that is, print from 2nd document


db.myCollection1.find();
db.myCollection1.find({},{"title":1,_id:0}).sort({"title":1})
db.myCollection1.find({},{"title":1,_id:0}).sort({"title":-1})
```

| Operation           | Syntax                | Example                                                  | RDBMS Equivalent           |
|---------------------|-----------------------|----------------------------------------------------------|----------------------------|
| Equality            | `{<key>:<value>}`     | `db.myCollection1.find({"by":"tutorials point"}).pretty()` | `where by = 'tutorials point'` |
| Less Than           | `{<key>:{$lt:<value>}}` | `db.myCollection1.find({"likes":{$lt:50}}).pretty()`      | `where likes < 50`         |
| Less Than Equals    | `{<key>:{$lte:<value>}}` | `db.myCollection1.find({"likes":{$lte:50}}).pretty()`     | `where likes <= 50`        |
| Greater Than        | `{<key>:{$gt:<value>}}`  | `db.myCollection1.find({"likes":{$gt:50}}).pretty()`      | `where likes > 50`         |
| Greater Than Equals | `{<key>:{$gte:<value>}}` | `db.myCollection1.find({"likes":{$gte:50}}).pretty()`     | `where likes >= 50`        |
| Not Equals          | `{<key>:{$ne:<value>}}`  | `db.myCollection1.find({"likes":{$ne:50}}).pretty()`      | `where likes != 50`        |


- find with $or: []
```js
db.myCollection1.find(
	{
		$or: [
			{firstName: "fn2"},
			{firstName: "fn3"}
		]
	}
);
```

- find with $and: []
```js
db.myCollection1.find(
   {
	  $and: [
			{firstName: "fn1"},
			{lastName: "ln1"}
	- , {"likes" : 20.0},
	-   {"likes": 100}
	-   {key1: value1}, {key2:value2}
		]
   }
).pretty()
```



- find with $gt:nnn
```js
db.myCollection1.find(
{
	age:{
		{$lt: 40}
	}
}
);
```

- find within an object ("obj1.field1": '') 
> NOTE: double quotes for object is must
```js
db.myCollection1.find(
{
	"address.city": "boston"
}
);
```

- find within an array ("array1": 'arrayval1') 
>NOTE: double quotes for object is must
```js
db.myCollection1.find(
{
	"array1": "arrayval1"
}
);
```

- find 
	- sort ascending 
	- by a field
```js
db.myCollection1.find().sort(
{"firstName": 1}
);
```

- find 
	- sort descending 
	- by a field
```js
db.myCollection1.find().sort(
{"firstName": -1}
);
```

- find 
	- count()
```js
db.myCollection1.find().count();
```

- find 
	- limit(nnn) 
	- 1st nnn
```js
db.myCollection1.find().limit(4)
```

- find 
	- limit(nnn) 1st nnn 
	- sort
```js
db.myCollection1.find().limit(4).sort({"firstName": 1});
```


- find 
	- limit(nnn) 1st nnn 
	- sort
```js
db.myCollection1.find().forEach(function(doc) { print("Customer name: " + doc.firstName) });
```


## drop		
- delete the 'myCollection1' collection
```js
db.myCollection1.drop1()
//NOTE:	rename 'drop1' to 'drop' if you really want to delete collection (drop1 existing eliminate accidental deletion)
db.test.save( { a: 1} )
db.test.find()

- db.dropDatabase()
```

## Aggregation
- process data records and return computed results group values from multiple documents together can perform a variety of operations on the grouped data to return a single result.
- In SQL count(*) and with group by is an equivalent of mongodb aggregation.

----------------------------
| Expression   | Description                                                                                     | Example                                                                                              |
|--------------|-------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| $sum         | Sums up the defined value from all documents in the collection.                                 | `db.myCollection1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$sum : "$likes"}}}])`        |
| $avg         | Calculates the average of all given values from all documents in the collection.                | `db.myCollection1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$avg : "$likes"}}}])`        |
| $min         | Gets the minimum of the corresponding values from all documents in the collection.              | `db.myCollection1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$min : "$likes"}}}])`        |
| $max         | Gets the maximum of the corresponding values from all documents in the collection.              | `db.myCollection1.aggregate([{$group : {_id : "$by_user", num_tutorial : {$max : "$likes"}}}])`        |
| $push        | Inserts the value to an array in the resulting document.                                         | `db.myCollection1.aggregate([{$group : {_id : "$by_user", url : {$push: "$url"}}}])`                  |
| $addToSet    | Inserts the value to an array in the resulting document but does not create duplicates.         | `db.myCollection1.aggregate([{$group : {_id : "$by_user", url : {$addToSet : "$url"}}}])`             |
| $first       | Gets the first document from the source documents according to the grouping.                    | `db.myCollection1.aggregate([{$group : {_id : "$by_user", first_url : {$first : "$url"}}}])`          |
| $last        | Gets the last document from the source documents according to the grouping.                     | `db.myCollection1.aggregate([{$group : {_id : "$by_user", last_url : {$last : "$url"}}}])`            |



- display aggregate, 
```js
db.myCollection1.aggregate([
    {
    - $group : {                          - group by
            _id : "$by_user",               - group by 'by_user'       => per user
            num_of_books_1: {
            - $sum : 1                    - number of books ($sum), per user,   here, 1 means +ve sum
            }
        }
    }
])
```

## Pipeline
- In UNIX command, shell pipeline means the possibility to execute an operation on some input and use the output as the input for the next command and so on.
- MongoDB also supports same concept in aggregation framework. 
- There is a set of possible stages and each of those take a set of documents as an input and produces a resulting set of documents (or the final resulting JSON document at the end of the pipeline). 
- These can then in turn be used for the next stage and so on.

## Following are the possible stages in aggregation framework -
- $limit      
	- This limits the amount of documents to look at, by the given number starting from the current positions.
- $skip       
	- With this, it is possible to skip forward in the list of documents for a given amount of documents.
- $sort       
	- Sorts the documents.
- $project    
	- Used to select some specific fields from a collection.
- $group      
	- This does the actual aggregation as discussed above.
- $match      
	- This is a filtering operation and thus this can reduce the amount of documents that are given as input to the next stage.
- $unwind     
	- This is used to unwind document that are using arrays. When using an array, the data is kind of pre-joined and this operation will be undone with this to have individual documents again. Thus with this stage we will increase the amount of documents for the next stage.
---------------------------------


| Parameter           | Type           | Description                                                                                                                                                                                                                   |
|---------------------|----------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| background          | Boolean        | Builds the index in the background so that building an index does not block other database activities. Specify true to build in the background. The default value is false.                                                    |
| unique              | Boolean        | Creates a unique index so that the collection will not accept insertion of documents where the index key or keys match an existing value in the index. Specify true to create a unique index. The default value is false. |
| name                | string         | The name of the index. If unspecified, MongoDB generates an index name by concatenating the names of the indexed fields and the sort order.                                                                                  |
| dropDups            | Boolean        | Creates a unique index on a field that may have duplicates. MongoDB indexes only the first occurrence of a key and removes all documents from the collection that contain subsequent occurrences of that key. Specify true to create unique index. The default value is false. |
| sparse              | Boolean        | If true, the index only references documents with the specified field. These indexes use less space but behave differently in some situations (particularly sorts). The default value is false.                             |
| expireAfterSeconds  | integer        | Specifies a value, in seconds, as a TTL to control how long MongoDB retains documents in this collection.                                                                                                                    |
| v                   | index version  | The index version number. The default index version depends on the version of MongoDB running when creating the index.                                                                                                       |
| weights             | document       | The weight is a number ranging from 1 to 99,999 and denotes the significance of the field relative to the other indexed fields in terms of the score.                                                                        |
| default_language    | string         | For a text index, the language that determines the list of stop words and the rules for the stemmer and tokenizer. The default value is english.                                                                              |
| language_override   | string         | For a text index, specify the name of the field in the document that contains the language to override the default language. The default value is language.                                                                   |


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


## LOAD FROM DB SCRIPT FILE
db.load('C:\mydbscript.js')

## USERS
```js
use financial
db.createUser(
	{
		user: "user1_whoCanReadWrite_and_is_dbAdmin",
		pwd: "123",
		roles: ["readWrite", "dbAdmin"]
	}
)

- Successfully added user
db_name = db.toString()
db.createUser(
	{
		user: "user1_whoCanReadViews",
		pwd: "123",
		roles: [ db_name + "_readAnyView"]
	}
)
```

# Roles
- use admin
```js
db.runCommand(
	{
		createRole: "readViewCollection",
		privileges: [
			{
				resource: {
					db: "",
					collection: "system.views"
				},
				actions: [ "find" ]
			}
		],
		roles : []
	}
)
db.grantRoleToUser('user1', ['readViewCollection'])
```

## REPLICA SET
- start "MongoDB replica set"
- mongod --port "PORT" --dbpath "YOUR_DB_DATA_PATH" --replSet "REPLICA_SET_INSTANCE_NAME" mongod --port 27017  --dbpath "C:\mongodb\replica-set\data" --replSet rs0

## In Mongo client
- rs.initiate()   - to initiate a new replica set.
- rs.conf()       - To check the replica set configuration, issue the command
- rs.status()     - To check the status of replica set issue the command
- db.isMaster()   - You can add mongod instance to replica set only when you are connected to primary node

## ADD NODES
- NOTE: start mongod instances on multiple machines
- rs.add(HOST_NAME:PORT)
- rs.add("mongod1.net:27017")
- rs.add("mongod2.net:27017")

- db
- https://www.myCollection1.com/mongodb/mongodb_sharding.htm

- stop Mongo
- https://docs.mongodb.com/manual/tutorial/manage-mongodb-processes/
- stop mongo (standalone)
- use admin
- db.shutdownServer()

## Stop a Replica Set
- db.shutdownServer({timeoutSecs : 5})                    - wait for 5 seconds, till secondaries catch up - If no secondaries catch up, it will not shut down
- db.adminCommand({shutdown : 1, timeoutSecs : 5})        - wait for 5 seconds, till secondaries catch up - If no secondaries catch up, it will not shut down
- db.adminCommand({shutdown : 1, force : true})           - If there is no up-to-date secondary and you want the primary to shut down

## INTERRUPT
- interrupts a running operation at the next interrupt point.
- db.currentOp()
- db.killOp(<opId>)


## robomongo

# A
installiNG robomongo IDE
	https://robomongo.org/download
	> Download > Windows > "Download installer for Windows 64-bit"
	Install
		Next > Next > Finish

# B
Connecting to mongo db
1. Start Robot 3T from desktop icon
2. Ctrl + N  to get "MongoDB Connections" (do if required)
3. Create
	Name: 		localmongo
	Address:	localhost		PORT: 27017
					Save
4. Connect
5. Right click on "test" database > Open shell



## for old versions of mongodb
# 1
download & install
	Community Server
	https://www.mongodb.com/download-center

# 2
start server
	mkdir c:\data\db
	mkdir c:\data\log
	"C:\Program Files\MongoDB\Server\3.4\bin\mongod.exe"

>NOTE: Now the server is running

More:
- "C:\Program Files\MongoDB\Server\3.4\bin\mongod.exe" --dbpath "d:\test\mongodb\data"
- (IF you want to run as service)
- "C:\Program Files\MongoDB\Server\3.4\bin\mongod.exe" --config "C:\Program Files\MongoDB\Server\3.4\mongod.cfg" --install

# 3
start client
	"C:\Program Files\MongoDB\Server\3.4\bin\mongo.exe"

start mongo as a server
	install config
		mongod --config "C:\data\mongo.cfg" --install
	start service
		net start mongodb
	stop service
		net stop mongodb
