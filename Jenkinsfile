pipeline {
    agent any
    environment {
        TF_IN_AUTOMATION = 'true'
    }
    stages {
        stage('Init & Task 3') {
            steps {
                sh 'terraform init'
                sh 'cat main.tfvars'
            }
        }
        stage('Plan & Apply - Task 4 & 5') {
            steps {
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh 'terraform plan -var-file=main.tfvars -out=tfplan'
                    
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }
}