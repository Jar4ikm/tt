pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('File') {
            steps {
                sh docker build -t myapp .
            }
        }
    }
}
