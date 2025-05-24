pipeline {
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    agent   {
        label 'kubernetes'
    }
    stages  {
        stage('Git')    {
            git url:'https://github.com/manishpcp/Website-PRT-ORG/', branch: 'main'
        }
        stage('Docker')  {
            steps {
                sh 'sudo docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                sh 'sudo docker build /home/ubuntu/jenkins/workspace/my-project-pipeline/ -t manishpcp/prt-task'
                sh 'sudo docker push manishpcp/prt-task'
            }
        }
        stage('K8s')   {
            steps {
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl apply -f service.yaml'
                }
            }
        }


}
