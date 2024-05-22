podTemplate(
    yaml: """
apiVersion: v1
kind: Pod
metadata:
  name: buildah
spec:
  containers:
  - name: buildah
    image: quay.io/buildah/stable:v1.23.1
    command:
    - cat
    tty: true
    volumeMounts:
      - name: varlibcontainers
        mountPath: /var/lib/containers
  volumes:
    - name: varlibcontainers
""") {
    node(POD_LABEL) {
        stage('buildah test') {
            container('buildah') {
                sh 'buildah --version'
            }
        }
    }
}
