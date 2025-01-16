# About this spike
This spike will create a Postgres database server and a dictioanry service, on Django server, which will read the data from the Postgres database.

## How to create and run the containers

### Step 1
Run the following command in the directory where docker-compose.yml resides.
```
    docker-compose up --build 
```
This will create the two servers running. Before accessing the servers, run the following command to find out the name of the django container. 
```
    docker ps
```
This should return the list of the up-and-running containers. 

### Step 2
Run migrate so the required data will be created and django server will be ready to use.
Replace django_server_container_name with the corresponding name found out by running 'docker ps' in Step 1.
```
docker exec -it django_server_container_name python manage.py migrate
```

### Step 3
Create the super user in django server.
```
docker exec -it django_server_container_name python manage.py createsuperuser
```
Follow the steps accordingly to create a super user. Note down the user name and password as required for later use (though it is not needed for this spike).

### Step 4
To liaise with Postgres database, a frontend tool will be needed. Application like pgAdmin can be used. 
Then using the frontend application, create a table, and insert a few rows for testing.
```
CREATE TABLE tbldef (
	id SERIAL PRIMARY KEY,
    word TEXT,
    definition TEXT
);

insert into tbldef (word, definition) values ('Hello', 'greeting word to use any time of a day');
insert into tbldef (word, definition) values ('Goodbye', 'parting word');
```

### Step 5
Finally service can be tested by calling as follows.
```
http://localhost:8000/api/define/?word=Hello
```