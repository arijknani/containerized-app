podTemplate(name: 'buildah') {
    node(POD_LABEL) {
        stage('buildah test') {
            container('buildah') {
                sh 'buildah --version'
                sh 'buildah build -t myimage .'
            }
        }
    }
}
