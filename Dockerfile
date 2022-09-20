##FROM openjdk
##ARG JAR_FILE=target/*.jar
##COPY ${JAR_FILE} app.jar
##ENTRYPOINT ["java","-jar","/app.jar"]

FROM openjdk
FROM maven:latest
# image layer
WORKDIR /app
ADD pom.xml /app
RUN mvn verify clean --fail-never

# Image layer: with the application
COPY . /app
RUN mvn -v
RUN mvn clean install -DskipTests
EXPOSE 8080
ADD ./target/demo-0.0.1-SNAPSHOT.jar /developments/
ENTRYPOINT ["java","-jar","/developments/demo-0.0.1-SNAPSHOT.jar"]