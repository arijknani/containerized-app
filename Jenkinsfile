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
    imagePullPolicy: Always
    image: quay.io/podman/stable:latest
    command:
    - cat
    tty: true
    securityContext:
      allowPrivilegedContainer: true
    serviceAccountName: test-buildah
    volumeMounts:
    - mountPath: /var/lib/containers
      name: podman-volume
    - mountPath: /dev/shm
      name: devshm-volume
    - mountPath: /var/run
      name: varrun-volume
    - mountPath: /tmp
      name: tmp-volume
  restartPolicy: Never
  volumes:
  - name: podman-volume
    emptyDir: {}
  - name: devshm-volume
    emptyDir:
      medium: Memory
  - name: varrun-volume
    emptyDir: {}
  - name: tmp-volume
    emptyDir: {}

'''   
    }
  }

environment {
        DOCKER_CREDS = credentials('dockerhub-cred')
    }
  stages {
    stage('Remove all images from agent') {
      steps {
        sh 'podman version'
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
