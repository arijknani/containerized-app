podTemplate(
    containers: [containerTemplate(image: 'quay.io/buildah/stable:v1.23.1', name: 'buildah', command: 'cat', ttyEnabled: true)]
) 
{
  node(POD_LABEL) {
    stage('buildah test') {
            container('maven') {
                sh 'buildah version'
            }
        }
  }
}
