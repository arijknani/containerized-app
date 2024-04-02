pipeline {
    agent { any { image 'maven:3.9.6-eclipse-temurin-17-alpine' } }
    tools {
        maven '3.9.1'
    }
    
    stages {
        stage('Build') {
            steps {
                sh "mvn -version"
                sh 'mvn -B -DskipTests clean package'
            }
        }
    }
}
