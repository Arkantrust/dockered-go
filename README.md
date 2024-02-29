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
  --network go-roach-net \
  -p 26257:26257 \
  -p 8080:8080 \
  -v roachdb:/cockroach/cockroach-data \
  cockroachdb/cockroach:latest-v20.1 start-single-node \
  --insecure
```

Once the DB engine is running, you must:

1. Create a blank database.
2. Register a new user account with the database engine.
3. Grant that new user access rights to the database.

```powershell
$ docker exec -it roach ./cockroach sql --insecure

> CREATE DATABASE go;

> CREATE USER arkan;

> GRANT ALL ON DATABASE go TO arkan;

> quit
```

Then to run the container:

```powershell
docker run -it --rm -d \
  --network go-roach-net \
  --name messages \
  -p 80:8080 \
  -e PGUSER=arkan \
  -e PGPASSWORD=password \
  -e PGHOST=db \
  -e PGPORT=26257 \
  -e PGDATABASE=go \
  arkantrust/docker-go:2.0.0
```

> I need to find a way to connect using only the url `DATABASE_URL=cockroachdb://arkan:password@db:26257/go`

> Because we ran the DB in `insecure` mode, we can connect to it without SSL and assign any password to it.

Then it can be queried using:

```powershell
curl --request POST \
--url http://127.0.0.1/send \
--header 'content-type: application/json' \
--data '{"value": "Hello, Arkan!"}'  
```

## License

[Apache-2.0 License](./LICENSE)
