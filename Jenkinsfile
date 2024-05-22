podTemplate(containers: [
    containerTemplate(name: 'maven', image: 'maven:alpine', ttyEnabled: true, command: 'cat')
]) {
    node(POD_LABEL) {
        stage('maven test') {
            container('maven') {
                sh 'mvn -version'
            }
        }
    }
}
