pipeline {
    environment {
        QUAY_CREDS = credentials('quay_creds')
        quay_repo = "arijknani"
        image_name = "my-app"
        app_name = "pfe-project"
        openshift_project = "arij-project"
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
    image: quay.io/buildah/stable:latest
    command:
    - cat
    tty: true
    securityContext:
      capabilities:
        add: ["SETFCAP"]
    volumeMounts:
      - name: varlibcontainers
        mountPath: /var/lib/containers
  volumes:
    - name: varlibcontainers
      emptyDir: {}
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
                    sh 'buildah version'
                    sh 'ls -al'
                    sh 'buildah build --storage-driver=vfs -t ${quay_repo}/${image_name} -f Dockerfile .'
                }
            }
        }

        stage('Login to quay') {
            steps {
                container('buildah') {
                    sh 'echo $QUAY_CREDS_PSW | buildah login -u $QUAY_CREDS_USR --password-stdin quay.io'
                }
            }
        }


        stage('push image') {
            steps {
                container('buildah') {
                    sh 'buildah push --storage-driver=vfs quay.io/${quay_repo}/${image_name}'
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
                        def deploymentExists = sh(script: "oc get deploy/${app_name}", returnStatus: true) == 0
                        if (deploymentExists) {
                            echo "Deployment ${app_name} exists, refreshing app..."
                            sh"oc set triggers deploy/${app_name} --from-image=${app_name}:latest "
                            sh "oc rollout restart deploy/${app_name}"
                        } else {
                            echo "Deployment ${app_name} does not exist, deploying app..."
                            sh "oc new-app --image=quay.io/${quay_repo}/${image_name} --name=${app_name} -c ${app_name}"
                            sh "oc set env --from=secret/app-secrets deploy/${app_name}"
                            sh "oc set env --from=configmap/app-configmap  deploy/${app_name}"
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
        sh 'buildah logout quay.io'
      }
    }
  }
}
