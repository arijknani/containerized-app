@Library('shared-library') _
def config = [name: 'Newman', dayOfWeek: 'Friday']
node('maven') {
        stage('test') {
            container('maven') {
                mavenVersion()
            }
        }
        stage('Example') {
            steps {
                helloWorld(config)
            }

        }
    }



