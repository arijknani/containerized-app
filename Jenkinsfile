pipeline {
    agent any
    environment {
        OPENSHIFT_CREDS = credentials('openshift-token')
        OPENSHIFT_SERVER="https://api.sandbox-m3.1530.p1.openshiftapps.com:6443"
        DOCKER_REPO= "arijknani009"
        IMAGE = "my-app"
        TAG= "latest" 
        REGISTRY_URL = "docker.io/${DOCKER_REPO}/${IMAGE}:${TAG}"
        APP_NAME = "test-pip"
        APP_SECRET = "app-secrets"
        APP_CM = "app-configmap"
    }
    stages {
        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                        installation: 'oc', 
                        url: '${OPENSHIFT_SERVER}', 
                        insecure: true, 
                        credentialsId: '$OPENSHIFT_CREDS']) { 
                        def deploymentExists = sh(script: "oc get dc/${APP_NAME}", returnStatus: true) == 0
                        if (!deploymentExists) {
                            echo "Deployment ${APP_NAME} does not exist, deployment app..."
                            sh "oc new-app --docker-image=${REGISTRY_URL} --name=${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME}"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME}"
                            sh "oc expose svc/${APP_NAME}"
                        } else {
                            echo "Deployment ${APP_NAME} exists, refreshing app..."
                            sh "oc rollout latest dc/${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME} "
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME} "
                            
                        }
                    }
                }
            }
        }
    }
}
