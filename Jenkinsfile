pipeline {
  agent {
    kubernetes {
      defaultContainer 'buildah'
    }
  }

  stages {
    stage('Run buildah') {
      steps {
        sh 'buildah version'
      }
    }
  }
}
