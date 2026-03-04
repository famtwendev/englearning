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
cd .\backend\ 
.\mvnw.cmd clean install -DskipTests
```
or
```bash
cd .\backend\ 
./mvnw clean install -DskipTests
```
or Run a service in Microservice (Example: API Gateway)
```bash 
cd api-gateway; 
..\mvnw.cmd spring-boot:run
```
If the Maven error was due to Java processes still holding files, remember to use:
```bash
taskkill /IM java.exe /F
```
### 3. Run Microservices
You need to run the API Gateway and other relevant services. For testing Phase 2, `api-gateway` and `identity-service` are required.
#### Option 1: Run each service
Open separate terminal windows for each service:

**Terminal 1 (Identity Service)**
```bash
java -jar identity-service/target/identity-service-1.0.0-SNAPSHOT.jar
```

**Terminal 2 (API Gateway)**
```bash
java -jar api-gateway/target/api-gateway-1.0.0-SNAPSHOT.jar
```

**Terminal 3 (Core Learning Service)**
```bash
java -jar core-learning-service/target/core-learning-service-1.0.0-SNAPSHOT.jar
```
#### Option 2: Run all servers
```bash
.\start_all.bat
```

The gateway maps endpoints such as `/api/v1/auth/**` to the identity service, and `/api/v1/topics/**` / `/api/v1/progress/**` to the core learning service.

### 4. Consolidated Swagger UI (API Documentation)
The backend project aggregates all documentation into a single easy-to-use Swagger UI hosted on the API Gateway at port 8080.

1. Ensure the `api-gateway`, `identity-service`, and `core-learning-service` are running.
2. Open your browser and go to:
   [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)
3. Upon first startup, the `identity-service` will automatically seed a default Administrator user to allow you to interact with secured endpoints.
4. From the top-right "Select a definition" dropdown, you can switch between:
   - `Identity Service`
   - `Core Learning Service`

**Default Admin Credentials:**
- **Email:** `admin@system.com`
- **Password:** `Admin@123`

To securely test endpoints directly from Swagger:
1. Navigate to the `Identity Service` spec.
2. Open `POST /api/v1/auth/login`.
3. Provide the above admin credentials and copy the `token` from the response string.
4. Click the **Authorize** icon (padlock) at the top of the Swagger UI and insert your copied token. Now all requests within the gateway UI will be verified correctly using the Admin role.


To import data into the database via PowerShell:
```bash
cd 'e:\eng-app\backend\core-learning-service'
.\import_script.ps1
# Cách 1: Chạy trực tiếp (Nó sẽ ngầm định dùng file mental_and_physical_development.json)
#.\import_script.ps1
# Cách 2: Chèn tên file linh hoạt ở đằng sau đuôi lệnh
#.\import_script.ps1 -File "keeping_fit.json"
```