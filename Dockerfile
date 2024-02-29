# build the app
FROM maven:latest AS build
ENV home /home/app
WORKDIR ${home}
# Copy everything from the current directory into /home/app
COPY . ${home}/
# builds the project, packages it, and installs the artifact into the local Maven repository
RUN mvn package -DskipTests

# create the final image
FROM openjdk:latest
WORKDIR ${home}
COPY --from=build ${home}/target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]