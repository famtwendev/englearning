# ============================================================
# Stage 1: Build
# Build context: backend/ (cần parent pom.xml)
# ============================================================
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /build

COPY pom.xml ./pom.xml
COPY ai-evaluator-service/pom.xml ai-evaluator-service/pom.xml

RUN mkdir -p ai-evaluator-service/src/main/java && \
    mvn -pl ai-evaluator-service dependency:resolve -B --no-transfer-progress 2>/dev/null || true

COPY ai-evaluator-service/src ai-evaluator-service/src

RUN mvn -pl ai-evaluator-service package -DskipTests -B --no-transfer-progress

# ============================================================
# Stage 2: Runtime
# ============================================================
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

COPY --from=builder /build/ai-evaluator-service/target/*.jar app.jar

RUN chown spring:spring app.jar

USER spring

EXPOSE 8084

ENTRYPOINT ["java", "-jar", "app.jar"]
