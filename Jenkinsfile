pipeline {
    agent {
        kubernetes
    }
    stages {
        stage('connect to openshift') {
            steps {
                script {
                    withEnv(["PATH+OC=${tool 'oc'}"]) {
                        openshift.withCluster('openshift-cluster') {
                            sh 'oc login -u arij -p openshift --insecure-skip-tls-verify=true https://api.ocp4.smartek.ae:6443'
                            echo "${openshift.raw('version').out}"
                            echo "In project: ${openshift.project()}"
                        }
                    }
                }
            }
        }
    }
}

