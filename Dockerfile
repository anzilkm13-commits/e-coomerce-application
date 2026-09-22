FROM eclipse-temurin:23-jdk
WORKDIR /app
COPY target/ecom-proj.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]