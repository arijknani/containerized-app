pipeline {
    agent any 
    tools {
        maven 'maven3'
        dockerTool 'docker'
    }
    stages {
        stage('Set Maven Home') {
            steps {
                script {
                    def mvnHome = tool 'maven3'
                    env.PATH = "${mvnHome}/bin:${env.PATH}"
                }
            }
        }
        stage('Build') {
            steps {
                sh 'mvn -version'
                sh 'mvn -B clean verify'
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
