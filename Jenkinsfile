pipeline {
    agent {
        label 'kubernetes'
    }

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }

    stages {
        stage('Fetch') {
            steps {
                git url: 'https://github.com/manishpcp/Website-PRT-ORG/', branch: 'main'
            }
        }

        stage('Docker') {
            steps {
                script {
                    sh "sudo docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
                    sh "sudo docker build -t manishpcp/prt-task ."
                    sh "sudo docker push manishpcp/prt-task"
                }
            }
        }

        stage('K8s') {
            steps {
                sh 'sudo kubectl apply -f k8s-manifests/deployment.yaml'
                sh 'sudo kubectl apply -f k8s-manifests/service.yaml'
            }
        }
    }
}
