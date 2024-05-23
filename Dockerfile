FROM image-registry.openshift-image-registry.svc:5000/openshift/java:8 AS build
ENV home=/home/app
WORKDIR ${home}
COPY . ${home}/
RUN mvn package -Dmaven.test.skip=true


FROM image-registry.openshift-image-registry.svc:5000/openshift/java:8
WORKDIR ${home}
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
#COPY  ./target/*.jar app.jar
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]
