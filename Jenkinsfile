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
      privileged : true
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
        OPENSHIFT_CREDS = credentials('openshift-token')
        APP_NAME = "test-pip"
        REGISTRY_URL = "docker.io/arijknani009/my-app"
        APP_SECRET = "app-secrets"
        APP_CM = "app-configmap"
        OPENSHIFT_SERVER="https://api.sandbox-m3.1530.p1.openshiftapps.com:6443"
    }

    stages {
        stage('Build with Buildah') {
            steps {
                container('buildah') {
                    sh 'buildah build -t arijknani009/my-app:latest .'
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
                    sh 'buildah tag arijknani009/my-app:latest arijknani009/my-app:latest'
                }
            }
        }

        stage('push image') {
            steps {
                container('buildah') {
                    sh 'buildah push arijknani009/my-app:latest'
                }
            }
        }

        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: ${OPENSHIFT_SERVER}, 
                        insecure: true, 
                        credentialsId: ${OPENSHIFT_CREDS}]) { 
                        
                        def deploymentExists = sh(script: "oc get dc/${APP_NAME}", returnStatus: true) == 0
                        if (!deploymentExists) {
                            echo "Deployment ${APP_NAME} does not exist, deployment app..."
                            sh "oc new-app --docker-image=${REGISTRY_URL} --name=${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME}"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME}"
                            sh "oc expose svc/${APP_NAME}"
                        } else {
                            echo "Deployment ${APP_NAME} exists, refreshing app..."
                            sh "oc rollout latest dc/${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME} --overwrite"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME} --overwrite"
                            
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
