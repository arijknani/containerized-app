pipeline {
    agent any

    stages {
        stage('Initialize') {
            steps {
                script {
                    def dockerHome = tool 'docker'
                    def mavenHome  = tool 'mvn'
                    env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
                }
            }
        }

        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'mvn -B -DskipTests clean package'  
                }
            }
        }

        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}
pipeline {
    agent any

    stage('Initialize')
    {
        def dockerHome = tool 'docker'
        def mavenHome  = tool 'mvn'
        env.PATH = "${dockerHome}/bin:${mavenHome}/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build') 
           {
            sh 'mvn -B -DskipTests clean package'  
          }

        
        stage('Docker Build') {
            steps {
                script {
                    sh 'docker build -t springboot-jenkins:latest .'
                }
            }
        }
    }
}

