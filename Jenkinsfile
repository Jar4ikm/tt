pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials') // Jenkins credentials ID
        DOCKER_IMAGE = 'jar4ik/apap' // Replace with your actual repository name
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Using docker.withRegistry to manage authentication and context
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_HUB_CREDENTIALS) {
                        def customImage = docker.build("jar4ik/apap:apap") // Build the image with the unique build ID
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests...'
                    // Using the latest built image to run tests
                    sh "docker run --rm jar4ik/apap:apap npm test"
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
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_HUB_CREDENTIALS) {
                        def customImage = docker.image("jar4ik/apap:apap")
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
                sh "docker rmi jar4ik/apap:apap || true"
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
