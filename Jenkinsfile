pipeline {
    agent any
    tools {
        maven 'maven3'
        dockerTool 'docker'
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn -version'
                sh 'mvn -B -DskipTests clean package'
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
    }
}
