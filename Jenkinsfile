pipeline {
    agent any
    stages {
        stage('Docker Build') {
            steps {
                script {
                    sh 'buildah build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}
