FROM openjdk:20-jdk-slim
# image layer
WORKDIR /app
ADD pom.xml /app
ADD . /app
RUN /app/mvnw verify clean package -DskipTest --fail-never

# Image layer: with the application
FROM openjdk:20-jdk-slim
WORKDIR /developments/
COPY --from=0 /app/target/*.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/developments/app.jar"]
