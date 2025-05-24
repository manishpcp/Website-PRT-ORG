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
                    sh "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
                    sh "docker build -t manishpcp/prt-task ."
                    sh "docker push manishpcp/prt-task"
                }
            }
        }

        stage('K8s') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
            }
        }
    }
}
