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
                        sh 'oc version' 
                        sh 'oc delete secret app-secrets '
                        sh 'oc delete configmap app-configmap-docker '
                        sh 'oc delete all -l app=springboot-docker'
                    }
                    
                }
            }
        }
    }
}
