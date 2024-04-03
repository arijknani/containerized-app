pipeline {
    agent any 
    
    environment {
        DOCKER_CREDS = credentials('docker-hub')
    }

    tools {
        maven 'maven3'
        dockerTool 'docker'
    }

    stages {
        stage('Docker Login') {
            steps {
                script {
                    sh 'docker login --username=${DOCKER_HUB_USER} --password=${DOCKER_HUB_PASSWORD}'
                }
            }
        }
        
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
