# Flyway Docker Migration Test

This project is looking to test using Flyway to migrate/create and populate database schemas.  The test includes connecting to and populating a Db2 database instance in the IBM Public Cloud and running in a Docker container on localhost.

The Docker container instance of DB2 will be used create an enviromonment on the fly for testing, demonstrations, education, and development.

Flyway itself (https://flywaydb.org) is an open source version control system for databases.  In Flyway all changes to a database schema are called migrations. Migrations can be either versioned or repeatable. Versioned migrations come in 2 forms: regular and undo.  The SQL will contain regular versions to create the DB2 objects (DDL) and repeatables to populate the newly created schema using insert statements (DML).

## The Db2 Docker Image
Use the following command to pull:

```cmd
docker run -itd --name db2_container_inst -e DBNAME=apidemo -v ~/:/database -e DB2INST1_PASSWORD=mY%tEst%pAsSwOrD -e LICENSE=accept -p 50000:50000 --privileged=true ibmcom/db2
```

- `docker run` is the docker command
- `-itd` are the options
    - `d` - start the container in detached mode. By design, containers started in detached mode exit when the root process used to run the container exits
    - `t` - Allocate a pseudo-tty (pseudo terminal)
    - `i` – Keep STDIN open even if not attached
- `--name` is the name given to the container, `db2_container_inst`.
- `-v` defines Volumes (shared filesystem).  Mounts ~/ into the container as /database which is where it will create the `apidemo` database (NOTE: if you’re interested in placing your database in a different location — which is probably advisable — just substitute ~/ with some other location.
- `-e` are the environment variables
    - `DB2INST1_PASSWORD` defines the password for the default Userid DB2INST1
    - `DBNAME` this creates the default database named `apidemo`.  This is optional.  Alternatively you can bash or connect to the Db2 instance and use standard `create database <db-name>` DDL
    - `LICENSE=accept` - Automatically accepts the user licence 
- `-p 50000:50000` - expose port 50000 and use the Docker internal port of 50000
- `--priviledge=true` - starts the container in privileged mode
- `ibncom/db2` the name of the image

**Note**, to have the container restated on a reboot or docker restart, the container is restarted add the option: `--restart unless-stopped`.

After starting the image, execute `docker ps` to verify that it is running.

