pipeline {
    agent any
    stages {
        stage('connect to openshift') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: 'https://api.ocp4.smartek.ae:6443', 
                        insecure: true, 
                        credentialsId: 'openshift-cred']) { 
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-secrets.yaml'
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-configmap.yaml'
                        sh 'oc delete all -l app=springboot-docker'
                        sh 'oc new-app https://github.com/arijknani/containerized-app.git#build-with-oc --name=springboot-docker --strategy=docker'
                        sh 'oc set env --from=secret/app-secrets  deployment/springboot-docker'
                        sh 'oc set env --from=configmap/app-configmap-docker  deployment/springboot-docker'
                        sh 'oc get routes'
                    }
                    
                }
            }
        }
    }
}
