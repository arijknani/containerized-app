pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.7.0-debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
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
          sh '''#!/busybox/sh
            echo "
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
                    ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]" > Dockerfile
            /kaniko/executor --context `pwd` --destination arijknani009/test-kaniko:latest 
          '''
        }
      }
    }
  }
}
