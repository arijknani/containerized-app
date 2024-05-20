pipeline {
    agent any
    environment {
        APP_NAME = "test-pip"
        REGISTRY_URL = "docker.io/arijknani009/my-app"
        APP_SECRET = "app-secrets"
        APP_CM = "app-configmap"
    }
    stages {
        stage('connect to openshift') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: 'https://api.sandbox-m3.1530.p1.openshiftapps.com:6443', 
                        insecure: true, 
                        credentialsId: 'openshift-token']) { 
                        
                        def deploymentExists = sh(script: "oc get dc/${APP_NAME}", returnStatus: true) == 0
                        if (!deploymentExists) {
                            echo "Deployment ${APP_NAME} does not exist, deployment app..."
                            sh "oc new-app --docker-image=${REGISTRY_URL} --name=${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME}"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME}"
                            sh "oc expose svc/${APP_NAME}"
                        } else {
                            echo "Deployment ${APP_NAME} exists, refreshing app..."
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME} --overwrite"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME} --overwrite"
                            sh "oc oc rollout restart dc/${APP_NAME}"
                        }
                    }
                }
            }
        }
    }
}
