pipeline {
  agent {
    kubernetes {
      yaml """
kind: Pod
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.14.0-debug
    imagePullPolicy: Always
    command:
    - sleep
    args:
    - 9999999
    securityContext:
      allowPrivilegedContainer: true
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
  environment {
        DOCKERFILE = "${env.WORKSPACE}/Dockerfile"
        BUILD_CONTEXT = "${env.WORKSPACE}"
    }
  stages {
    stage('Build with Kaniko') {
      steps {
        container(name: 'kaniko', shell: '/busybox/sh') {
          sh '''#!/busybox/sh
            /kaniko/executor  --context ${BUILD_CONTEXT} --dockerfile ${DOCKERFILE} --additional-whitelist="//bin/sh" --verbosity=debug --destination arijknani009/test-kaniko:latest 
          '''
        }
      }
    }
  }
}
