pipeline {
    agent any
    environment {
        TF_IN_AUTOMATION = 'true'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }
    stages {
        stage('Init & Task 3') {
            steps {
                sh 'terraform init'
                // We hardcode 'main' here so it can't be 'null'
                sh "cat main.tfvars" 
            }
        }
        stage('Plan - Task 4') {
            steps {
                sh "terraform plan -var-file=main.tfvars -out=tfplan"
            }
        }
        stage('Task 5: Manual Gate') {
            steps {
                // This will stop the pipeline and wait for you to click 'Approve'
                input message: "Approve deployment?", ok: "Approve"
            }
        }
    }
}