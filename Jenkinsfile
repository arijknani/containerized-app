podTemplate(
    label 'kubernetes'
    containers: [containerTemplate(name: 'maven', image: 'maven:alpine', command: 'cat', args: '')]) {

    node(kubernetes) {
        stage('Get a Maven project') {
            container('maven') {
                stage('Build a Maven project') {
                    sh 'mvn -version'
                }
            }
        }
    }
}
