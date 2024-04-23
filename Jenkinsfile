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
                        sh'oc apply -f ${WORKSPACE}/manifests/app-secrets.yaml'
                        sh'oc apply -f ${WORKSPACE}/manifests/app-configmap.yaml'
                        
                    }
                    
                }
            }
        }
    }
}
