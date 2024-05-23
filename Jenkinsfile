pipeline {
    agent {
        kubernetes 
    }
    stages {
        stage('buildah test') {
            steps {
                container('test') {
                    sh 'echo "test "'
                }
            }
        }
    }
}
