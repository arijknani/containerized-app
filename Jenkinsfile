pipeline {
    agent {
        kubernetes {
            yaml """
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - "9999999"
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
        - secret:
            name: docker-credentials
            items:
              - key: .dockerconfigjson
                path: config.json
"""
        }
    }
    
    stages {
        stage('Build with Kaniko') {
            steps {
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh '''
#!/busybox/sh
echo "
#Build the app
FROM maven:latest AS build
WORKDIR /home/app
#Copy everything from the current directory into /home/app
COPY . /home/app
#Build the project, package it, and install the artifact into the local Maven repository
RUN mvn package -Dmaven.test.skip=true
#Create the final image
FROM openjdk:latest
WORKDIR /home/app
EXPOSE 8080
COPY --from=build /home/app/target/*.jar app.jar
ENTRYPOINT ['java', '-Dspring.profiles.active=prod', '-jar', 'app.jar']" > Dockerfile

#Execute Kaniko to build the image
/kaniko/executor --context `pwd` --verbosity debug --destination arijknani009/build-app:latest
'''
                }
            }
        }
    }
}
