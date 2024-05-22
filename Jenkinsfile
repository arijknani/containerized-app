pipeline {
    environment {
        DOCKER_CREDS = credentials('dockerhub_creds')
        docker_repo= "arijknani009"
        docker_image = "my-app" 
        app_name = "test-pip"
         }
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
    
    stages {
        stage('Build with Buildah') {
            steps {
                container('buildah') {
                    sh 'buildah build -t ${docker_repo}/${docker_image} .'
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


        stage('push image') {
            steps {
                container('buildah') {
                    sh 'buildah push ${docker_repo}/${docker_image}:latest'
                }
            }
        }

        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                          installation: 'oc', 
                          url: 'https://api.ocp.smartek.ae:6443', 
                          insecure: true, 
                          credentialsId: 'openshift_creds']) { 
                        sh "oc project ${openshift_project}"
                        def deploymentExists = sh(script: "oc get dc/${app_name}", returnStatus: true) == 0
                        if (deploymentExists) {
                            echo "Deployment ${app_name} exists, refreshing app..."
                            sh "oc tag docker.io/${docker_repo}/${image_name}:latest ${app_name}:latest "
                            sh "oc rollout latest dc/${app_name}"
                        } else {
                            echo "Deployment ${app_name} does not exist, deploying app..."
                            sh "oc new-app --docker-image=docker.io/${docker_repo}/${image_name} --name=${app_name}"
                            sh "oc expose svc/${app_name}"
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
