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
                    sh 'docker --version'
                    sh 'docker build -t springboot-jenkins:latest .'
                }
            }
        }

        stage('Run') {
            steps {
                sh 'docker run -d -p 8000:8000 --name springboot-jenkins-app springboot-jenkins'
            }
        }
    }
}
