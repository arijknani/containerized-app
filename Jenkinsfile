pipeline {
agent any
environment {
        DOCKER_CREDS = credentials('dockerhub-cred')
    }
  stages {
    stage('Remove all images from agent') {
      steps {
        sh 'podman rmi --all --force'
      }
    }
    stage('build image') {
      steps {
        sh 'podman build -t arijknani009/test-podman:latest .'
      }
    }
    stage('Login to Docker Hub') {
      steps {
        container('buildah') {
          sh 'echo $DOCKER_CREDS_PSW | buildah login -u $DOCKER_CREDS_USR --password-stdin docker.io'
        }
      }
    }
   } 
}
