pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  containers:
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
  tools {
        maven 'maven3'
}
  

  stages {

    stage('Build with Kaniko') {
      steps {
        container('kaniko') {
          sh '/kaniko/executor  --context $WORKSPACE --dockerfile $WORKSPACE/Dockerfile --verbosity=debug  --destination arijknani009/pfe-app:latest  '
        }
      }
    }
  }
}
