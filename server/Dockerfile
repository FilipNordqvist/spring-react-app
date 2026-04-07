# Stage 1: Build
FROM maven:3-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN if [ -f proxy-ca.crt ]; then \
      keytool -importcert -noprompt -keystore $JAVA_HOME/lib/security/cacerts \
        -storepass changeit -alias proxy-ca -file proxy-ca.crt; \
    fi
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
# Vi kopierar jar-filen och döper den till app.jar för enkelhetens skull
COPY --from=build /app/target/*.jar app.jar

# Railway sätter PORT via miljövariabel, lokalt faller vi tillbaka på 8080
ENV PORT=8080

CMD ["java", "-jar", "app.jar"]