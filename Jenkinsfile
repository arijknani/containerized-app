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
    securityContext:
      RunAsUser : 0
      #allowPrivilegedContainer: true
      #privileged: true 
    volumeMounts:
      - name: varlibcontainers
        mountPath: /var/lib/containers
  volumes:
    - name: varlibcontainers
""") 
{
    node(POD_LABEL) {
        stage('buildah test') {
            container('buildah') {
                sh 'buildah build arijknani/my-app . '
            }
        }
    }
}
