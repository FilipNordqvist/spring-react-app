# Stage 1: Build
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /app
COPY server/pom.xml .
# Dependency caching: download deps first so source changes don't re-download.
# || true because go-offline may partially fail on optional plugins; the real
# build in the next step will catch genuine errors.
RUN mvn dependency:go-offline -B || true
COPY server/src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Railway sätter PORT via miljövariabel, lokalt faller vi tillbaka på 8080
ENV PORT=8080

CMD ["java", "-jar", "app.jar"]