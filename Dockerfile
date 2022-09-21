FROM openjdk
#FROM maven:latest
# image layer
WORKDIR /app
ADD pom.xml /app
ADD . /app
RUN /app/mvnw verify clean package -DskipTest --fail-never

# Image layer: with the application
FROM openjdk
WORKDIR /developments/
COPY --from=0 /app/target/*.jar ./
EXPOSE 8080
ENTRYPOINT ["java","-jar","/developments/demo-0.0.1-SNAPSHOT.jar"]
