# installation
	download mongodb
		https://www.mongodb.com/download-center

		select
			"Community server" tab
				> "Windows
					> download
		install
			take defaults (Next, Next,  Finish)

			
    check if exists - server 
		mongod
			MongoDB server version: 4.0.0
			MongoDB shell version v4.0.0
			connecting to: mongodb://127.0.0.1:27017
			
			show dbs;
				admin   0.000GB
				config  0.000GB
				local   0.000GB

		
    check if exists - client
		mongo
			show dbs;
			exit;


	NOTE:
		Data directory		C:\Program Files\MongoDB\Server\4.0\data\
		Log  directory		C:\Program Files\MongoDB\Server\4.0\log\

## 3 setup types:
- Standalone MongoDB instance             https://docs.mongodb.com/manual/reference/program/mongod/
- MongoDB replica set          https://docs.mongodb.com/manual/replication/
- MongoDB sharded clusters     https://docs.mongodb.com/manual/sharding/


## 2
	mongodb
		server is
			mongod
		client (official) are
			mongo
				starts the mongodb shell, to connect to above server
			mongodb compass
				SQL IDE/ UI, to connect to above server

				## How to configure your mongodb server so that it can be accessed, from another machine
- Below error comes up when we access local mongodb server, from a mongodb client on remote machine
- "Error: MongoDB not running on the provided host and port"
- Go here: https://stackoverflow.com/a/51718461/984471


## List of mongo db clients
| Category           | Status  | Tool Name                        | Latest Commit      | GitHub Repository                                         | Description                                                                                      |
|--------------------|---------|----------------------------------|--------------------|-----------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **free & opensource** | **active** | mongo shell                      | -                  | -                                                         | -                                                                                                |
|                    |         | mongo-express                    | Latest commit c3c94bd 5 days ago | [mongo-express](https://github.com/mongo-express/mongo-express) | Web-based MongoDB admin interface, written with Node.js and express                          |
|                    |         | nosqlclient (mongoclient)        | Latest commit b1b65ba 8 days ago | [nosqlclient](https://github.com/nosqlclient/nosqlclient)  | -                                                                                                |
| **inactive**          |         | mongodb admin tool for php       | Latest commit 4b1a16e on 14 May 2017 | [phpMoAdmin-MongoDB-Admin-Tool-for-PHP](https://github.com/MongoDB-Rox/phpMoAdmin-MongoDB-Admin-Tool-for-PHP) | -                                                                                                |
|                    |         | edda                             | Latest commit 5acaf99 on 25 Oct 2016 | [edda](https://github.com/mongodb-labs/edda)               | A log visualizer for MongoDB                                                                    |
|                    |         | rockmongo                        | Latest commit 939017a on 19 Sep 2015 | [rockmongo](https://github.com/iwind/rockmongo)             | -                                                                                                |
|                    |         | mongo explorer                   | Latest commit fc85825 on 17 Mar 2015 | [MongoExplorer](https://github.com/tutikka/MongoExplorer)  | Cross-platform database management tool for MongoDB                                            |
|                    |         | mongodb sharding visualizer      | Latest commit a54bbc4 on 26 Nov 2014 | [shard-viz](https://github.com/mongodb-labs/shard-viz)     | [MongoDB sharding visualizer](https://www.mongodb.com/blog/post/mongodb-sharding-visualizer)   |
|                    |         | umongo                           | Latest commit 44dfa90 on 20 Jun 2014 | [umongo](https://github.com/agirbal/umongo)                | -                                                                                                |
|                    |         | genghis                          | Latest commit 717910d on 20 Mar 2014 | [genghis](https://github.com/bobthecow/genghis/)            | [Genghis](http://genghisapp.com)                                                                |
|                    |         | mongohub **mac only**            | Latest commit accf03b on 19 Apr 2015 | [MongoHub-Mac](https://github.com/jeromelebel/MongoHub-Mac) | -                                                                                                |
| **free & commercial** | **active** | robo 3t (robomongo)              | -                  | [Robo 3T](https://robomongo.org)                            | -                                                                                                |
|                    |         | clustercontrol                   | -                  | [clustercontrol](https://github.com/severalnines/docker)    | -                                                                                                |
| **commercial**        |         | studio 3t - full                 | -                  | [studio 3t](https://studio3t.com)                           | -                                                                                                |
|                    |         | mongo management studio          | -                  | [mms.litixsoft.de](http://mms.litixsoft.de)                 | -                                                                                                |
|                    |         | mongodb compass                  | -                  | [docs-compass](https://github.com/mongodb/docs-compass)     | [MongoDB Compass](https://www.mongodb.com/products/compass)                                    |
|                    |         | mongobooster                     | -                  | [nosqlbooster](https://nosqlbooster.com/compareEditions)    | -                                                                                                |
| **commercial only**  | **active** | nosql manager                    | -                  | [mongodbmanager](http://mongodb-tools.com/tool/mongodbmanager/) | -                                                                                                |
|                    |         | nucleon database manager         | -                  | [nucleon-database-manager](https://www.g2crowd.com/products/nucleon-database-manager/details) | [Database Master](http://nucleonsoftware.com/products/database-master)                        |
| **inactive**          |         | mongojs query analyzer           | -                  | [dbspecific/mongodb_client](https://www.aquafold.com/dbspecific/mongodb_client) | -                                                                                                |
|                    |         | mongovue                         | -                  | [mongovue](http://www.mongovue.com)                        | -                                                                                                |

# shell commands
- Run the below at command prompt/ terminal
```shell
cmd
```

- start mongo client
```shell
mongo

db.stats();
db.help();
```