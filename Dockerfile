# Bước 1: Build dự án với Maven
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

# CHÚ Ý: Thay "bai-do-xe" bằng tên thư mục chính xác trên GitHub của bạn
COPY bai-do-xe/ .  

RUN mvn clean package -DskipTests

# Bước 2: Chạy ứng dụng (Dùng bản Temurin để ổn định hơn bản slim cũ)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Đảm bảo đường dẫn này khớp với file jar được tạo ra trong thư mục target
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
