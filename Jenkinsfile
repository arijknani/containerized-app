podTemplate(
    inheritFrom: 'my-pod',
    containers: [containerTemplate(image: 'maven:alpine', name: 'maven', command: 'cat', ttyEnabled: true)]) 
{
  node(POD_LABEL) {
    stage('buildah test') {
            container('maven') {
                sh 'mvn -version'
            }
        }
  }
}
