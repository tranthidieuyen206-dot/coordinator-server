# Bước 1: Build file jar bằng Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY coordinator-server/ .
RUN mvn clean package -DskipTests

# Bước 2: Chạy ứng dụng
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
