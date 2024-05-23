pipeline {
    agent {
        kubernetes {
            label 'buildah'
            defaultContainer 'buildah'
        }
    }
    stages {
        stage('buildah test') {
            steps {
                container('buildah') {
                    sh 'buildah --version'
                }
            }
        }
    }
}
