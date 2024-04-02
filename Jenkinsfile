pipeline {
    agent any 
    tools {
        maven 'maven3'
        dockerTool 'docker'
    }
    stages {
        stage('Docker Build') {
            steps {
                script {
                    sh 'podman build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}
