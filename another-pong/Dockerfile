FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN ./mvnw clean package -pl another-pong -am -Dmaven.test.skip=true

FROM eclipse-temurin:21-alpine
WORKDIR /app
COPY --from=build /app/another-pong/target/*.jar another-pong.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/another-pong.jar"]
