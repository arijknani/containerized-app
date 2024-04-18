pipeline {
agent {
    kubernetes {
      yaml '''
apiVersion: v1
kind: Pod
metadata:
  name: podman
spec:
  containers:
  - name: podman
    image: quay.io/podman/stable:latest
    command:
    - cat
    tty: true
    securityContext:
      allowPrivilegedContainer: true
    serviceAccountName: test-buildah
    volumeMounts:
      - name: podman-volume
        mountPath: /var/lib/containers
  volumes:
    - name: podman-volume
'''   
    }
  }

environment {
        DOCKER_CREDS = credentials('dockerhub-cred')
    }
  stages {
    stage('Remove all images from agent') {
      steps {
        sh 'podman --version'
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
