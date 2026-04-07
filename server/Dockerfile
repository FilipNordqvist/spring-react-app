# Stage 1: Build
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
# Vi kopierar jar-filen och döper den till app.jar för enkelhetens skull
COPY --from=build /app/target/*.jar app.jar

# Railway använder PORT-variabeln, lokalt faller vi tillbaka på 8080
ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]