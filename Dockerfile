FROM maven:latest AS build
USER root
WORKDIR /home/app
COPY . /home/app/
RUN mvn package -Dmaven.test.skip=true

FROM openjdk:latest
WORKDIR /home/app
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
