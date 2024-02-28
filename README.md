# Workshop: Dockerized Go

This is my improvement after following the [Docker's Go Language Guide](https://docs.docker.com/language/golang/) originally made by [olliefr](https://www.linkedin.com/in/ofr/), where a simple Go server/microservice is dockerized.

## Features

These were the features added to the original project:

- multi-stage `Dockerfile`
- Testing CI pipeline using GitHub Actions
- CD pipeline using GitHub Actions to publish to Docker Hub
- CockroachDB integration
- Docker Compose for local development

## License

[Apache-2.0 License](./LICENSE)
