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

# Giới hạn Maven chống ngốn CPU/RAM lúc Build
ENV MAVEN_OPTS="-XX:+TieredCompilation -XX:TieredStopAtLevel=1 -Xmx512m -XX:MaxMetaspaceSize=128m"

# Pre-download dependencies cho module này (tận dụng layer cache)
RUN mvn -pl core-learning-service dependency:go-offline -B --no-transfer-progress

# Copy source và build chỉ module này
COPY core-learning-service/src core-learning-service/src

RUN mvn -pl core-learning-service package -DskipTests -B --no-transfer-progress

# Giải nén JAR file thành các Layer (Spring Boot 3.3+)
WORKDIR /build/core-learning-service/target/extracted
RUN java -Djarmode=tools -jar ../*.jar extract --layers --destination .

# ============================================================
# Stage 2: Runtime
# ============================================================
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

# Tận dụng Layer Cache của Spring Boot
COPY --from=builder --chown=spring:spring /build/core-learning-service/target/extracted/dependencies/ ./
COPY --from=builder --chown=spring:spring /build/core-learning-service/target/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=spring:spring /build/core-learning-service/target/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=spring:spring /build/core-learning-service/target/extracted/application/ ./

USER spring

EXPOSE 8082

ENTRYPOINT ["sh", "-c", "exec java -jar *.jar"]
