pipeline {
    agent {
        kubernetes {
            yaml """
                kind: Pod
                spec:
                  containers:
                  - name: kaniko
                    image: gcr.io/kaniko-project/executor:debug
                    imagePullPolicy: Always
                    command:
                    - sleep
                    args:
                    - 9999999
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
                        /kaniko/executor --context `pwd` --dockerfile Dockerfile -v error --force --destination arijknani009/hello-kaniko:latest 
                    '''
                }
            }
        }
    }
}
