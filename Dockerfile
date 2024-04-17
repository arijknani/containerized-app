FROM jenkins/inbound-agent:latest
# build the app
FROM maven:latest AS build
ENV home=/home/app
WORKDIR ${home}
# Copy everything from the current directory into /home/app
COPY . ${home}/
# builds the project, packages it, and installs the artifact into the local Maven repository
RUN mvn package -Dmaven.test.skip=true

# create the final image
FROM openjdk:latest
WORKDIR ${home}
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
