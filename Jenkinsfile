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
                        
                        def buildConfigExists = sh(script: "oc get bc/${APP_NAME}", returnStatus: true) == 0
                        if (buildConfigExists) {
                            echo "BuildConfig ${APP_NAME} exists, starting new build to update app ..."
                            sh "oc start-build ${APP_NAME}"

                            def routeExists = sh(script: "oc get route/${APP_NAME}", returnStatus: true) == 0
                            if (!routeExists) {
                                echo "Route ${APP_NAME} does not exist, exposing service ..."
                                sh "oc expose svc/${APP_NAME}"
                            }
                        } else {
                            echo "BuildConfig ${APP_NAME} does not exist, creating app ..."
                            sh "oc new-app --docker-image=${REGISTRY_URL} --name=${APP_NAME}"
                            sh "oc set env --from=secret/${APP_SECRET} dc/${APP_NAME}"
                            sh "oc set env --from=configmap/${APP_CM} dc/${APP_NAME}"
                            sh "oc expose svc/${APP_NAME}"
                        }
                    }
                }
            }
        }
    }
}
