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
                sh "touch file.txt"
                sh "echo 'hEllo' >> file.txt"
                sh "cat file.txt"
            }
        }
    }
}
