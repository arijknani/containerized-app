pipeline {
    agent any
    stages {
        stage('connect to openshift') {
            steps {
                script {
                    echo '$WORKSPACE'
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: 'https://api.ocp4.smartek.ae:6443', 
                        insecure: true, 
                        credentialsId: 'openshift-cred']) { 
                        sh 'oc version' 
                    }
                    
                }
            }
        }
    }
}
