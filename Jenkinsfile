@Library('shared-library') _
def config = [quay_repo: 'arijknani', image_name: 'my-app', app_name: 'test-library',openshift_project:'arij-project' ]
pipeline {
    agent any
    stages {
        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                          installation: 'oc', 
                          url: 'https://api.ocp.smartek.ae:6443', 
                          insecure: true, 
                          credentialsId: 'openshift_creds']) { 
                        deployOpenshift(config)
                    }
                }
            }
        }
    }
}

