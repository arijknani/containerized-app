pipeline {
    agent any
    
    tools {
        maven 'maven'
        dockerTool 'docker'
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
