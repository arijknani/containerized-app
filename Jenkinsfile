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
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-secrets.yaml'
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-configmap.yaml'
                        sh 'oc delete all -l app=my-app'
                        sh 'oc delete istag/my-app'
                        sh 'oc create istag my-app:latest --from-image=docker.io/arijknani009/my-app:latest'
                        sh 'oc new-app --image-stream=my-app'
                        sh 'oc set env --from=secret/app-secrets  deployment/my-app'
                        sh 'oc set env --from=configmap/app-configmap  deployment/my-app'
                        sh 'oc expose service/my-app'                
                    }
                    
                }
            }
        }
    }
}
