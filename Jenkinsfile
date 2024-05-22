pipeline {
    agent any
    environment {
        docker_repo = "arijknani009"
        image_name = "my-app"
        app_name = "test-oc"
        openshift_project = "arijknani-dev"
    }
    stages {
        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                          installation: 'oc', 
                          url: 'https://api.sandbox-m3.1530.p1.openshiftapps.com:6443', 
                          insecure: true, 
                          credentialsId: 'openshift_creds']) { 
                        sh "oc project ${openshift_project}"
                        def deploymentExists = sh(script: "oc get dc/${app_name}", returnStatus: true) == 0
                        if (deploymentExists) {
                            echo "Deployment ${app_name} exists, refreshing app..."
                            sh "oc set image dc/${app_name} ${app_name}=docker.io/${docker_repo}/${image_name}:latest"
                            def rolloutStatus = sh(script: "oc rollout status dc/${app_name}", returnStatus: true) != 0
                            if (rolloutStatus) {
                                echo "Waiting for the ongoing rollout to complete..."
                                sh "oc rollout status dc/${app_name} --watch"
                            }
                            sh "oc rollout restart dc/${app_name}"
                        } else {
                            echo "Deployment ${app_name} does not exist, deploying app..."
                            sh "oc new-app --docker-image=docker.io/${docker_repo}/${image_name} --name=${app_name}"
                            sh "oc expose svc/${app_name}"
                        }
                    }
                }
            }
        }
    }
}
