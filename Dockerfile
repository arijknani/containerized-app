# build the app
FROM maven:latest AS build
ENV home=/home/app
WORKDIR ${home}

