podTemplate(
    inheritFrom: 'my-pod',
    containers: [containerTemplate(name: 'maven')]) 
{
  node(POD_LABEL) {
    stage('buildah test') {
            container('maven') {
                sh 'mvn -version'
            }
        }
  }
}
