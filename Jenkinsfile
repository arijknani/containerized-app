pipeline {
    agent { any { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    tools {
        maven 'maven3'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -version'
                sh 'mvn -B -DskipTests clean package'
            }
        }
    }
}
