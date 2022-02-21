pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh "make --file=Makefile_nec build"
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh 'cmake CMakeLists.txt'
                sh 'make'
                sh "make --file=Makefile_nec test"
            }
             
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}