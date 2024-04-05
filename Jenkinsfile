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
    environment {
        DOCKER_CREDS = credentials('docker-hub')
    }
    tools {
        dockerTool 'docker'
    }
    stages {
        stage('Docker Login') {
            steps {
                script {
                    sh 'docker -v'
                    sh 'docker login --username=${DOCKER_CREDS_USR} --password=${DOCKER_CREDS_PSW}'
                }
            }
        }
        stage('Build with Kaniko') {
            steps {
                container(name: 'kaniko', shell: '/busybox/sh') {
                    sh '''#!/busybox/sh
                        /kaniko/executor --context `pwd` --dockerfile Dockerfile -v Error --force --destination arijknani009/hello-kaniko:latest 
                    '''
                }
            }
        }
    }
}
