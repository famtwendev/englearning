# English Learning MVP - Backend

This is the backend for the English Learning MVP, built with Java Spring Boot and a Granular Microservices architecture.

## Prerequisites
- Java 17
- Docker & Docker Compose (for running PostgreSQL and Redis)
- Maven (Maven wrapper is included)

## Architecture
The backend is split into multiple microservices:
1. `api-gateway` (Port 8080): Routes requests to appropriate services.
2. `identity-service` (Port 8081): Manages Users, Authentication (JWT), and Roles.
3. `core-learning-service` (Port 8082): Manages Vocabulary, Topics, Grammar, and student progress.
4. `assessment-service`: Manages tests and quizzes.
5. `ai-evaluator-service`: Interfaces with AI for speaking/writing assessment.

## Getting Started

### 1. Start Support Services (Databases)
Navigate to the root of the backend folder (or project root, where `docker-compose.yml` is located) and start PostgreSQL and Redis:
```bash
docker-compose up -d
```

### 2. Build the Project
From the `backend` directory, build all microservices using Maven:
```bash
./mvnw clean install -DskipTests
```

### 3. Run Microservices
You need to run the API Gateway and other relevant services. For testing Phase 2, `api-gateway` and `identity-service` are required.

Open separate terminal windows for each service:

**Terminal 1 (Identity Service)**
```bash
cd identity-service
java -jar target/identity-service-1.0.0-SNAPSHOT.jar
```

**Terminal 2 (API Gateway)**
```bash
cd api-gateway
java -jar target/api-gateway-1.0.0-SNAPSHOT.jar
```

**Terminal 3 (Core Learning Service - When implemented)**
```bash
cd core-learning-service
java -jar target/core-learning-service-1.0.0-SNAPSHOT.jar
```

The gateway maps endpoints such as `/api/v1/auth/**` to the identity service.
