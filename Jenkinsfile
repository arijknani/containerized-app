pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}

