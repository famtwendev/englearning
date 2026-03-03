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
Where do you installed jdk?
Example: C:\Program Files\Java\jdk-24 or E:\Program Files\Java\jdk-24
If you don't have JAVA_HOME set, you can follow this link:
https://viblo.asia/p/cach-cai-dat-bien-java-home-tren-windows-10-series-java-handbook-phan-2-aNj4vXA0L6r
Run command in **Command Prompt**
From the `backend` directory, build all microservices using Maven:
```bash
echo %JAVA_HOME%
cd backend
mvnw.cmd clean install -DskipTests
```
or
```bash
./mvnw clean install -DskipTests
```

### 3. Run Microservices
You need to run the API Gateway and other relevant services. For testing Phase 2, `api-gateway` and `identity-service` are required.

Open separate terminal windows for each service:

**Terminal 1 (Identity Service)**
```bash
java -jar identity-service/target/identity-service-1.0.0-SNAPSHOT.jar
```

**Terminal 2 (API Gateway)**
```bash
java -jar api-gateway/target/api-gateway-1.0.0-SNAPSHOT.jar
```

**Terminal 3 (Core Learning Service - When implemented)**
```bash
cd core-learning-service
java -jar target/core-learning-service-1.0.0-SNAPSHOT.jar
```

The gateway maps endpoints such as `/api/v1/auth/**` to the identity service.
