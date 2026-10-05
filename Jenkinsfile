pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building application...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'mvn test'
            }
        }
    }

    post {
        success {
            echo '========================================'
            echo '       PIPELINE SUCCESS'
            echo '========================================'
        }

        failure {
            echo '========================================'
            echo '       PIPELINE FAILED'
            echo '========================================'
        }
    }
}
