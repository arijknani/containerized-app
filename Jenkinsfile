pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
metadata:
  name: buildah
spec:
  containers:
  - name: buildah
    image: quay.io/buildah/stable:v1.23.1
    command:
    - cat
    tty: true
    securityContext:
      privileged: true
    volumeMounts:
      - name: varlibcontainers
        mountPath: /var/lib/containers
  volumes:
    - name: varlibcontainers
'''
        }
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
        durabilityHint('PERFORMANCE_OPTIMIZED')
        disableConcurrentBuilds()
    }
    environment {
        DOCKER_CREDS = credentials('dockerhub-cred')
    }

    stages {
        stage('Build with Buildah') {
            steps {
                container('buildah') {
                    sh 'buildah build -t arijknani009/example-buildah:latest .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                container('buildah') {
                    sh 'echo $DOCKER_CREDS_PSW | buildah login -u $DOCKER_CREDS_USR --password-stdin docker.io'
                }
            }
        }
        stage('tag image') {
            steps {
                container('buildah') {
                    sh 'buildah tag arijknani009/example-buildah:latest arijknani009/example-buildah:latest'
                }
            }
        }
        stage('push image') {
            steps {
                container('buildah') {
                    sh 'buildah push arijknani009/example-buildah:latest'
                }
            }
        }
        stage('connect to OpenShift') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: 'https://api.ocp4.smartek.ae:6443',  
                        credentialsId: 'openshift-cred']) {
                            sh 'oc apply -f ${WORKSPACE}/manifests/app-secrets.yaml'
                            sh 'oc apply -f ${WORKSPACE}/manifests/app-configmap.yaml'
                            sh 'oc delete all -l app=springboot-app'
                            sh 'oc new-app  https://github.com/arijknani/containerized-app.git#CasC --name=springboot-app --strategy=docker'
                            sh 'oc set env --from=secret/app-secrets  deployment/springboot-app'
                            sh 'oc set env --from=configmap/app-configmap  deployment/springboot-app'
                            sh 'oc expose service/springboot-app'                
                            sh 'oc get routes'
                    }
                    }
                }
            }
        }
    }

    post {
        always {
            container('buildah') {
                sh 'buildah logout docker.io'
            }
        }
    }
}
