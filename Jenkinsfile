pipeline {
    agent any
    tools {
        maven 'maven3'
        dockerTool 'docker'
    }


        stage('Docker Build') {
            steps {
                script {
                    sh 'buildah build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}
