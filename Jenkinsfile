pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  containers:
  - name: maven
    image: maven:3.8.3-adoptopenjdk-11
    command:
    - cat
    tty: true
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.14.0-debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    securityContext:
      allowPrivilegedContainer: true
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
    stage('Build with maven'){
      steps {
        container('maven'){
          sh 'mvn package -Dmaven.test.skip=true'
        }
      }
    }
    
    stage('Build with Kaniko') {
      steps {
        container('kaniko') {
          sh '/kaniko/executor  --context $WORKSPACE --dockerfile $WORKSPACE/Dockerfile --verbosity=debug  --no-push --destination arijknani009/pfe-app:latest  '
        }
      }
    }
  }
}
