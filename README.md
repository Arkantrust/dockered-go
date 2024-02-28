# Workshop: Dockerized Go

This is my improvement after following the [Docker's Go Language Guide](https://docs.docker.com/language/golang/) originally made by [olliefr](https://www.linkedin.com/in/ofr/), where a simple Go server/microservice is dockerized.

## Features

These were the features added to the original project:

- multi-stage `Dockerfile`
- Testing CI pipeline using GitHub Actions
- CD pipeline using GitHub Actions to publish to Docker Hub
- CockroachDB integration
- Docker Compose for local development

## Configuring CockroachDB

To run the project, you need to have a CockroachDB instance running. You can use the following command to start a CockroachDB instance using Docker:

```powershell

$ docker volume create roachdb

$ docker network create -d bridge go-roach-net

$ docker run -d \
  --name roach \
  --hostname db \
  --network mynet \
  -p 26257:26257 \
  -p 8080:8080 \
  -v roach:/cockroach/cockroach-data \
  cockroachdb/cockroach:latest-v20.1 start-single-node \
  --insecure
```

Once the DB engine is running, you must:

1. Create a blank database.
2. Register a new user account with the database engine.
3. Grant that new user access rights to the database.

```powershell
$ docker exec -it roachdb ./cockroach sql --insecure

> CREATE DATABASE go;

> CREATE USER arkan;

> GRANT ALL ON DATABASE go TO arkan;

> quit
```

## License

[Apache-2.0 License](./LICENSE)
