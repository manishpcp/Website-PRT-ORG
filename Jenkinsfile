pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "manishpcp/website-prt-org"
        DOCKER_TAG = "latest"
        KUBE_CONFIG = credentials('kubeconfig') // Optional: Jenkins credential ID
    }

    triggers {
        pollSCM('* * * * *')  // Poll for changes every minute (customize this)
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            agent { label 'docker-agent' }
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-creds', url: '']) {
                    script {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Build or deployment failed!'
        }
    }
}
