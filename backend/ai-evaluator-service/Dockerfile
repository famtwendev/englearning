# ============================================================
# Stage 1: Build
# Build context: backend/ (cần parent pom.xml)
# ============================================================
FROM maven:3.9-eclipse-temurin-21-alpine AS builder

WORKDIR /build

COPY pom.xml ./pom.xml
COPY ai-evaluator-service/pom.xml ai-evaluator-service/pom.xml

# Giới hạn Maven chống ngốn CPU/RAM lúc Build
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx512m -XX:MaxMetaspaceSize=128m"

RUN mkdir -p ai-evaluator-service/src/main/java && \
    mvn -pl ai-evaluator-service dependency:resolve -B --no-transfer-progress 2>/dev/null || true

COPY ai-evaluator-service/src ai-evaluator-service/src

RUN mvn -pl ai-evaluator-service package -DskipTests -B --no-transfer-progress

# Giải nén JAR file thành các Layer (Spring Boot 3.3+)
WORKDIR /build/ai-evaluator-service/target/extracted
RUN java -Djarmode=tools -jar ../*.jar extract --layers --destination .

# ============================================================
# Stage 2: Runtime
# ============================================================
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

# Tận dụng Layer Cache của Spring Boot
COPY --from=builder --chown=spring:spring /build/ai-evaluator-service/target/extracted/dependencies/ ./
COPY --from=builder --chown=spring:spring /build/ai-evaluator-service/target/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=spring:spring /build/ai-evaluator-service/target/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=spring:spring /build/ai-evaluator-service/target/extracted/application/ ./

USER spring

EXPOSE 8084

ENTRYPOINT ["sh", "-c", "exec java -jar *.jar"]
