pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE = 'jar4ik/apap' // Замените на реальное имя вашего репозитория
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo "test"
                    echo("${env.DOCKER_IMAGE}")
                    echo 'Building Docker image...'
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests...'
                    sh 'docker run --rm $DOCKER_IMAGE:$DOCKER_TAG npm test'
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
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }
    }

    post {
        always {
            script {
                def image = "${DOCKER_IMAGE}"
                def tag = "${DOCKER_TAG}"
                echo 'Cleaning up...'
                sh "docker rmi ${image}:${tag} || true"
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
