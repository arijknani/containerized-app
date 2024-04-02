pipeline {
    agent any
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
