#base image from docker hub,specifies the Parent image from which you are building
FROM openjdk
#define the working directory of a docker container
WORKDIR /opt
#informs docker that the container listens on the specified network
EXPOSE 8080
COPY target/*.jar /opt/app.jar
ENTRYPOINT ["java", "-jar", "/opt/app.jar"]