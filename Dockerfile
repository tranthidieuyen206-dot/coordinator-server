# Bước 1: Build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Chép nội dung từ thư mục coordinator-server vào /app trong Docker
COPY coordinator-server/ .  

RUN mvn clean package -DskipTests

# Bước 2: Run
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Lấy file jar đã được shade (fat jar) để chạy
COPY --from=build /app/target/coordinator-server-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
