# Flyway Docker Migration Test

**Table of Contents**

1. [Overview](#1.0)
1. [The Db2 Docker Image](#2.0)
1. [Flyway setup](#3.0)
    1. [conf/flyeway.conf](#3.1)
    1. [drivers](#3.2)
    1. [sql](#3.2)
1. [Running Flyway Natively](#4.0)
1. [Running Flyway from a container](#5.0)     
1. [Issue running Flyway from a container to Db2 container instance](#6.0)  


<a id="1.0"></a>

## Overview

This project is looking to test using Flyway to migrate/create and populate database schemas.  The test includes connecting to and populating a Db2 database instance in the IBM Public Cloud and running in a Docker container on localhost.

The Docker container instance of DB2 will be used create an enviromonment on the fly for testing, demonstrations, education, and development.

Flyway itself (https://flywaydb.org) is an open source version control system for databases.  In Flyway all changes to a database schema are called migrations. Migrations can be either versioned or repeatable. Versioned migrations come in 2 forms: regular and undo.  The SQL will contain regular versions to create the DB2 objects (DDL) and repeatables to populate the newly created schema using insert statements (DML).

<a id="2.0"></a>

## The Db2 Docker Image
Use the following command to pull:

```shell
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

<a id="3.0"></a>

## Flyway setup

Flywaydb, by default, allows for a simple directory structure to be set up to run a migration. These directories are:
- `conf` – Directory containing the configuration file, flyway.conf
- `drivers` – Directory containing the JDBC driver for the target database
- `sql` – Directory with the SQL files that define the database schema (DDL) and content (DML) you are looking to build.

Looking at the content of each of these directories:

<a id="3.1"></a>

### conf/flyway.conf 
This configuration file requires only 3 parameters:
1. `flyway.url` – the JDBC URL for the target database
2. `flyway.user` – the Userid needed to connect to the target database
3. `flyway.password` – the password for the Userid needed to connect to the target database

To connect to the Db2 container instance the following `flyway.conf` file has been defined in the `conf` directory.

```shell
flyway.url=jdbc:db2://localhost:50000/apidemo
flyway.user=DB2INST1
flyway.password=mY%tEst%pAsSwOrD
```

To connect to the Db2 instance on the IBM Public Cloud the copy  `flyway.conf.db2_public` file into the `flyway.conf` file has been defined in the `conf` directory

<a id="3.2"></a>

### drivers
In the `drivers` directory, the DB2 JDBC Type 4 drivers were added (e.g. `db2jcc4.jar`, `db2jcc_license_cisuz.jar`).

<a id="3.3"></a>

### sql
Finally, in the SQL directory are the DDL and DML files used to create and populate the data schema, respectively.  Note that Flywaydb requires a specific file naming convention, which has been applied.

<a id="4.0"></a>

## Running Flyway Natively
To run Flyway locally, you need to download and install the application.  Provided the user has Flyway installed (Flyway and the Java JRE are included in this repo), the user can run a Flyway migration against either Db2 running in a container or on the IBM Public Cloud by issuing the following command:

```shell
./flyway clean migrate
```

<a id="5.0"></a>

## Running Flyway as a Container
Since however we want non-developers to be able to run the ApiFramework, we can run Flyway in a container.

The easiest way to get started is simply to test the image by running

```shell
docker run --rm flyway/flyway
```

This will give you Flyway Command-line's usage instructions.

The `--rm` causes Docker to automatically remove the container when it exits.

Note, if you need to find Docker images available locally, you can run: `docker images` or `docker image ls`.

To make it easy to run Flyway the way you want to, the following volumes are supported:
- `/flyway/conf`
- `/flyway/drivers`
- `/flyway/sql`
- `/flyway/jars`	The jar files for Flyway to use for Java migration (not used for SQL migration)

Mounting the conf, drivers, and sql directories to these volumes, we can create the flyway container and initiate the database setup and population.

```shell
docker run --rm -v /Users/steve/github-ibm/flyway-db-migration/  
sql:/flyway/sql -v /Users/steve/github-ibm/flyway-db-migration/  
conf:/flyway/conf -v /Users/steve/github-ibm/flyway-db-migration/  
drivers:/flyway/drivers flyway/flyway migrate
```

or, without line breaks (for copy and paste)
```shell
docker run --rm -v /Users/steve/github-ibm/flyway-db-migration/sql:/flyway/sql -v /Users/steve/github-ibm/flyway-db-migration/conf:/flyway/conf -v /Users/steve/github-ibm/flyway-db-migration/drivers:/flyway/drivers flyway/flyway migrate
```

<a id="6.0"></a>

## Issue running Flyway from a container to Db2 container instance

The migration running Flyway natively works when run either against Db2 running in IBM's Public Cloud or in a container.  When running Flyway from a container, the migration works when running against Db2 running in IBM's Public Cloud but fails with a communication error when running against a Db2 container instance.

In both case, Flyway native and in a container, Flyway Community Edition 6.5.5 by Redgate is being used.


<table>
    <thead>
        <tr>
            <th>Flyway</th>
            <th>Db2 IBM Public Cloud</th>
            <th>Db2 Container Instance</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Native</td>
            <td style="text-align:center">&#9989;</td>
            <td style="text-align:center">&#9989;</td>
        </tr>
        <tr>
            <td>Container</td>
            <td style="text-align:center">&#9989;</td>
            <td style="text-align:center">&#10060;</td>
        </tr>
    </tbody>
</table>

**Error message received**

```
Unable to obtain connection from database (jdbc:db2://localhost:50000/apidemo) for user 'DB2INST1': 
[jcc][t4][2043][11550][4.22.29] Exception java.net.ConnectException: Error opening socket to server localhost/127.0.0.1 on port 50,000 with message:  
Connection refused (Connection refused). ERRORCODE=-4499, SQLSTATE=08001
```

**Cause**
A possible cause for this problem is that TCP/IP is not properly enabled on your DB2 database server.

**Resolving the Problem**
Use the db2set DB2COMM command from the DB2 command window to start the TCP/IP connection:
```shell
db2set DB2COMM=protocol_names
```

For example, to set the database manager to start connection managers for the TCP/IP communication protocols, enter the following commands

```shell
db2set DB2COMM=tcpip
db2stop force
db2start
```

**Actions**
Bash into the container:
```shell
docker exec -it db2_container_inst /bin/bash
```
Switched to needed user:
```shell
su - db2inst1
```
Set the `DB2COMM`:

```shell
db2set DB2COMM=TCPIP
db2stop force
db2start
```

Getting the same issue.

