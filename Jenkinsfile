pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    DOCKERHUB_USERNAME = 'manikantatoleti'  // <-- Replace this
    IMAGE_TAG = "${BUILD_NUMBER}"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/manikantatoleti99/cicd-end-to-end.git', branch: 'main'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh '''
          echo "Building Docker image..."
          docker build -t $DOCKERHUB_USERNAME/django-todo:$IMAGE_TAG .
        '''
      }
    }

    stage('Push Docker Image') {
      steps {
        sh '''
          echo "Logging into Docker Hub..."
          echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_USERNAME --password-stdin
          docker push $DOCKERHUB_USERNAME/django-todo:$IMAGE_TAG
        '''
      }
    }

    stage('Run Container') {
      steps {
        sh '''
          echo "Stopping existing container if exists..."
          docker stop django-todo || true
          docker rm django-todo || true

          echo "Running container from new image..."
          docker run -d --name django-todo -p 8000:8000 $DOCKERHUB_USERNAME/django-todo:$IMAGE_TAG
        '''
      }
    }
  }
}
