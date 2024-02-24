#build the app
FROM maven AS build
#working directory
WORKDIR /home/app
#Copy everything from the current directory into /home/app-prod
COPY . /home/app
#builds the project, packages it, and installs the artifact into the local Maven repository
RUN mvn -f /home/app/pom.xml clean install

#create the final image
FROM openjdk
EXPOSE 8080
WORKDIR /home/app
#Copy created jar file into the target folder
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]