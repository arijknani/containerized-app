FROM maven:latest AS build
ADD . /
RUN mvn package -Dmaven.test.skip=true

FROM openjdk:latest
EXPOSE 8080
COPY --from=build  /target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
