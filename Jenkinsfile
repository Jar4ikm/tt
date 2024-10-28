pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Using docker.withRegistry to manage authentication and context
                    docker.withRegistry('https://registry.hub.docker.com', docker-hub-credential) {
                        def customImage = docker.build("jar4ik/apap:latest") // Build the image with the unique build ID
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests...'
                    // Wrap in node context for proper shell execution
                    node {
                        // Using the latest built image to run tests
                        sh "docker run --rm jar4ik/apap:latest npm test"
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    echo 'Pushing Docker image to Docker Hub...'
                    docker.withRegistry('https://registry.hub.docker.com', docker-hub-credential) {
                        def customImage = docker.image("jar4ik/apap:latest")
                        customImage.push() // Push the built image to the registry
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up...'
                // Clean up the images after the build
                node {
                    // Clean up using a node context
                    sh "docker rmi jar4ik/apap:latest || true"
                }
            }
        }
        failure {
            echo 'Build failed.'
        }
        success {
            echo 'Build succeeded.'
        }
    }
}
