pipeline {
    agent any
    stages {
        stage('connect to openshift') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: 'https://api.sandbox-m3.1530.p1.openshiftapps.com:6443', 
                        insecure: true, 
                        credentialsId: 'openshift-token']) { 
                        sh 'oc version'
                    }
                    
                }
            }
        }
    }
}
