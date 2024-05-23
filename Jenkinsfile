@Library('shared-library') _
@Library('shared-library') _
def config = [name: 'Newman', dayOfWeek: 'Friday']
pipeline {
    agent any
    stages {
        stage('Example') {
            steps {
                helloWorld(config)
            }
        }
    }
}

