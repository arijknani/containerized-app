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
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-secrets.yaml'
                        sh 'oc apply -f ${WORKSPACE}/manifests/app-configmap.yaml'
                        sh 'oc delete all -l app=springboot-app'
                        sh 'oc new-app --as-deployment-config=false https://github.com/arijknani/containerized-app.git#build-with-oc --name=springboot-app --strategy=docker'
                        sh 'oc set env --from=secret/app-secrets  deployment/springboot-app'
                        sh 'oc set env --from=configmap/app-configmap  deployment/springboot-app'
                        sh 'oc expose service/springboot-app'
                        sh ' oc get deployment springboot-app -o yaml'
                        sh 'oc get routes'
                    }
                    
                }
            }
        }
    }
}
