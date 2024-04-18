FROM maven:latest AS build
RUN mvn package -Dmaven.test.skip=true

