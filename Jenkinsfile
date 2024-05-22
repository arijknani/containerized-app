pipeline {
    agent any
    environment {
        docker_repo = "arijknani009"
        image_name = "my-app"
        app_name = "test-oc"
        openshift_project = "arij-project"
    }
    stages {
        stage('deployment') {
            steps {
                script {
                    wrap([$class: 'OpenShiftBuildWrapper',  
                          installation: 'oc', 
                          url: 'https://api.ocp.smartek.ae:6443', 
                          insecure: true, 
                          credentialsId: 'openshift_creds']) { 
                        sh "oc project ${openshift_project}"
                        def deploymentExists = sh(script: "oc get deploy/${app_name}", returnStatus: true) == 0
                        if (deploymentExists) {
                            echo "Deployment ${app_name} exists, refreshing app..."
                            sh "oc tag docker.io/${docker_repo}/${image_name}:latest ${app_name}:latest "
                            sh "oc rollout restart deploy/${app_name}"
                        } else {
                            echo "Deployment ${app_name} does not exist, deploying app..."
                            sh "oc new-app --image=docker.io/${docker_repo}/${image_name} --name=${app_name}"
                            sh "oc expose svc/${app_name}"
                        }
                    }
                }
            }
        }
    }
}
