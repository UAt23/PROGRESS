pipeline {

    parameters {  
        string(name: 'APPLICATION_NAME', defaultValue: 'triangle', description: 'Name of the application') 
        string(name: 'MAKE_FILE_NAME', defaultValue: 'Makefile_nec', description: 'Makefile name') 
        string(name: 'VERSION', defaultValue: '1.0', description: 'Version Number') 
        string(name: 'REV_NUMBER', defaultValue: '1', description: 'Revision Number') 
        string(name: 'DEB_ARCHITECTURE', defaultValue: 'amd64', description: 'Debin Architecture') 
        
    }

    agent {
        dockerfile {
            filename "Dockerfile"
            args "-v /var/run/docker.sock:/var/run/docker.sock"
        }
    }

    stages {
        stage('Build') {
            steps {
                echo "Building ${params.APPLICATION_NAME}"
                sh "make --file=${MAKE_FILE_NAME} build APPLICATION_NAME=${params.APPLICATION_NAME}"
            }
        }
        stage('Test') {
            steps {
                echo "Testing ${params.APPLICATION_NAME}"
                sh 'cmake CMakeLists.txt'
                sh 'make'
                sh "make --file=${MAKE_FILE_NAME} test"
            }
             
        }
        stage('Deploy') {
            steps {
                echo "Deploying ${params.APPLICATION_NAME}"
                sh "make --file=${MAKE_FILE_NAME} dist APPLICATION_NAME=${params.APPLICATION_NAME} DEB_ARCHITECTURE=${params.DEB_ARCHITECTURE} REV_NUMBER=${params.REV_NUMBER} VERSION=${params.VERSION} MAKE_FILE_NAME=${params.MAKE_FILE_NAME}"
            }
        }
    }
}