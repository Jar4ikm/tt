pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-credentials')
        DOCKER_IMAGE = 'jar4ik/apapap' // Замените "username/my-app" на ваше имя репозитория в Docker Hub
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    // Собираем Docker-образ из Dockerfile в корне проекта
                    sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG .'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    echo 'Running tests...'
                    // Запускаем контейнер и тесты внутри него
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
                    // Логинимся на Docker Hub
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                    // Отправляем образ на Docker Hub
                    sh "docker push $DOCKER_IMAGE:$DOCKER_TAG"
                }
            }
        }
    }

    post {
        always {
            script {
                echo 'Cleaning up...'
                // Удаляем локальные образы для освобождения места
                sh "docker rmi $DOCKER_IMAGE:$DOCKER_TAG || true"
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
