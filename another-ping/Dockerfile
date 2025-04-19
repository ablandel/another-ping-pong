FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -pl another-ping -am -Dmaven.test.skip=true

FROM eclipse-temurin:21-alpine
WORKDIR /app
COPY --from=build /app/another-ping/target/*.jar another-ping.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/another-ping.jar"]
