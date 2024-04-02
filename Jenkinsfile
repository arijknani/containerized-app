pipeline {
    agent any
    
    tools {
        maven '3.9.6'
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
