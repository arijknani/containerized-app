FROM registry.redhat.io/redhat-openjdk-18/openjdk18-openshift AS build
ENV home=/home/app
WORKDIR ${home}
COPY . ${home}/
RUN mvn package -Dmaven.test.skip=true


FROM registry.redhat.io/redhat-openjdk-18/openjdk18-openshift
WORKDIR ${home}
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
#COPY  ./target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
