node('buildah') {
        stage('test') {
            container('buildah') {
                sh 'buildah version'
                sh 'buildah build arijknani/my-app . '
            }
        }
    }



