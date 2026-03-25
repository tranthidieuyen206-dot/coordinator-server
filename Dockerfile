# Bước 1: Build
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# Thay vì COPY . . , hãy chép nội dung TỪ TRONG thư mục coordinator-server vào
COPY coordinator-server/ .  

RUN mvn clean package -DskipTests

# Bước 2: Run (giữ nguyên như cũ)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
