# Stage 1: Build
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B || true
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Railway sätter PORT via miljövariabel, lokalt faller vi tillbaka på 8080
ENV PORT=8080

CMD ["java", "-jar", "app.jar"]