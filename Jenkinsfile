pipeline {
    agent { any { 
		image 'maven:3.9.6-eclipse-temurin-17-alpine' 
		args '-u root'
} }

    tools {
        maven 'maven3'
        dockerTool 'docker'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -version'
                sh 'mvn -DskipTests clean verify'
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
