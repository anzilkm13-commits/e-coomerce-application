# E-Commerce REST API

A Spring Boot REST API for a basic e-commerce workflow: managing users and products, maintaining a user cart, and creating orders from cart items.

The project is configured to run locally with an in-memory H2 database. A Dockerfile and a Docker Compose configuration are included for container-based development.

## Tech stack

- Java 21
- Spring Boot 3.5.0
- Spring Web
- Spring Data JPA / Hibernate
- H2 (default runtime database)
- MySQL Connector/J (runtime dependency)
- Spring Boot Actuator
- Maven and Lombok
- Docker and Docker Compose

## What it supports

- User creation, retrieval, and update, including an address
- Product creation, retrieval, update, deletion, and keyword search
- Cart operations using the `X-User-Id` request header
- Order creation from a cart, including item totals and order status

## Run locally

Prerequisite: Java 21.

```bash
./mvnw spring-boot:run
```

The API listens on `http://localhost:8080`.

The default datasource is the in-memory H2 database configured in `src/main/resources/application.properties`, so data is reset when the application stops.

## Build the JAR

```bash
./mvnw clean package
```

This produces `target/ecom-proj.jar`, which is intentionally ignored by Git.

## Run with Docker

Build the application before building the image, because the Dockerfile copies the packaged JAR from `target/`.

```bash
./mvnw clean package
docker build -t ecom-proj:local .
docker run --rm -p 8080:8080 ecom-proj:local
```

## Run with Docker Compose

The included Compose configuration starts a MySQL 8 container and the application container.

Create an ignored `.env` file from the example and replace the placeholder passwords before starting the stack:

```bash
cp .env.example .env
./mvnw clean package
docker compose up --build
```

For real deployments, supply database credentials through your deployment environment rather than committing them to the repository.

## API overview

All endpoints are under `http://localhost:8080/api`.

| Area | Endpoints |
| --- | --- |
| Users | `GET /users`, `GET /users/{id}`, `POST /users`, `PUT /users/{id}` |
| Products | `GET /products`, `GET /products/{id}`, `POST /products`, `PUT /products/{id}`, `DELETE /products/{id}`, `GET /products/search?keyword=...` |
| Cart | `POST /cart`, `GET /cart/items`, `DELETE /cart/items/{productId}` |
| Orders | `POST /orders` |

Cart and order requests require an `X-User-Id` header. For example:

```bash
curl -H "X-User-Id: <user-id>" http://localhost:8080/api/cart/items
```

## Project layout

```text
src/main/java/.../controller/  HTTP API controllers
src/main/java/.../service/     Business logic
src/main/java/.../repository/  Data access repositories
src/main/java/.../model/       JPA entities and enums
src/main/java/.../dto/         Request and response objects
src/main/resources/            Application configuration
Dockerfile                     Container image definition
docker-compose.yaml            Local multi-container setup
```

## Repository hygiene

Generated build output, IDE settings, macOS metadata, environment files, and private key files are excluded via `.gitignore`. Do not commit real credentials, API keys, or private deployment configuration.
