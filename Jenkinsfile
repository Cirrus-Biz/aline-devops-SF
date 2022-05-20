#!/usr/bin/env groovy

pipeline {

    agent {
        node {
            label 'dev-node'
        }
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
            }
        }

        stage('Test') {
            when {
                expression {
                    BRANCH_NAME = 'test'
                }
            }
            steps {
                echo 'Testing..'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }

    post {
        always {

        }

        failure {

        }

        success {
            
        }
    }
}
