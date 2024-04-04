pipeline {
    tools {
        maven 'maven3'
        dockerTool 'docker'
    }

    environment {
        registry = 'arijknani009/myapp-jenkins'
        registryCredential = 'docker-hub'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Building our image') {
            steps {
                script {
                    dockerImage = docker.build('${registry}:${BUILD_NUMBER}')
                }
            }
        }

        stage('Deploy our image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Cleaning up') {
            steps {
                script {
                    sh 'docker rmi ${registry}:${BUILD_NUMBER}'
                }
            }
        }
    }
}
