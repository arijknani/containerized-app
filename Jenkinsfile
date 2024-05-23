node('maven') {
        stage('test') {
            container('maven') {
                sh 'mvn -version'
            }
        }
    }

node('buildah') {
        stage('test') {
            container('buildah') {
                sh 'buildah version'
            }
        }
    }



