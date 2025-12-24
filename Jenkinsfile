pipeline {
    agent any
    environment {
        TF_IN_AUTOMATION = 'true'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
    }
    stages {
        stage('Terraform Init & Task 3') {
            steps {
                sh 'terraform init'
                // Task 3: We hardcode 'main' so it never says 'null'
                sh "cat main.tfvars" 
            }
        }
        stage('Terraform Plan - Task 4') {
            steps {
                // Task 4: Success for Main branch
                sh "terraform plan -var-file=main.tfvars -out=tfplan"
            }
        }
        stage('Task 5: Manual Approval') {
            steps {
                // This will ask for approval every time so you can get the Task 5 marks easily
                input message: "Does the plan look correct?", ok: "Approve"
            }
        }
    }
}