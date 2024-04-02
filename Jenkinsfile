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
                    docker.build('springboot-jenkins:latest')
                }
            }
        }
    }
}
