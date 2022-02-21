pipeline {
    agent {
        dockerfile {
            filename "Dockerfile"
            args "-v /var/run/docker.sock:/var/run/docker.sock"
        }
    }

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
                sh "make dist"
            }
        }
    }
}