pipeline {
    agent any
    stages {
        stage('Init & Task 3') {
            steps {
                sh 'terraform init'
                sh "cat main.tfvars" 
            }
        }
        stage('Plan - Task 4') {
            steps {
                // We wrap the plan in withCredentials to ensure they are fresh and clean
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh "terraform plan -var-file=main.tfvars -out=tfplan"
                }
            }
        }
        stage('Task 5: Manual Gate') {
            steps {
                input message: "Approve deployment?", ok: "Approve"
            }
        }
    }
}