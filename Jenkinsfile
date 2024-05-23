node('buildah') {
        stage('test') {
            container('buildah') {
                sh 'buildah version'
            }
        }
    }



node('maven') {
        stage('test') {
            container('maven') {
                sh 'mvn -version'
            }
        }
    }
