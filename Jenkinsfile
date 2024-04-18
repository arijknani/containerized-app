pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  runAsUser: 0
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    securityContext:
      allowPrivilegedContainer: true
    serviceAccountName: test-buildah
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    projected:
      sources:
      - secret:
          name: docker-credentials 
          items:
            - key: .dockerconfigjson
              path: config.json
"""
    }
  }
  stages {
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh
            /kaniko/executor --context `pwd`  --dockerfile Dockerfile  -v debug --destination arijknani009/test-kaniko:latest
          '''
        }
      }
    }
  }
}
