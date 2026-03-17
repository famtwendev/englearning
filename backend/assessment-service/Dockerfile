# ============================================================
# Stage 1: Build
# Build context: backend/ (cần parent pom.xml)
# ============================================================
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /build

# Copy parent pom + TẤT CẢ module pom để Maven resolve được project structure
COPY pom.xml ./pom.xml
COPY api-gateway/pom.xml             api-gateway/pom.xml
COPY identity-service/pom.xml        identity-service/pom.xml
COPY core-learning-service/pom.xml   core-learning-service/pom.xml
COPY assessment-service/pom.xml      assessment-service/pom.xml
COPY ai-evaluator-service/pom.xml    ai-evaluator-service/pom.xml

# Pre-download dependencies cho module này (tận dụng layer cache)
RUN mvn -pl assessment-service dependency:go-offline -B --no-transfer-progress

# Copy source và build chỉ module này
COPY assessment-service/src assessment-service/src

RUN mvn -pl assessment-service package -DskipTests -B --no-transfer-progress

# ============================================================
# Stage 2: Runtime
# ============================================================
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

COPY --from=builder /build/assessment-service/target/*.jar app.jar

RUN chown spring:spring app.jar

USER spring

EXPOSE 8083

ENTRYPOINT ["java", "-jar", "app.jar"]
