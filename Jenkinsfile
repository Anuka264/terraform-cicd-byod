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
                // We use 'credentialsId' to match the IDs you showed me in your screenshot
                withCredentials([
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    // Adding -input=false ensures terraform never stops to ask questions
                    sh "terraform plan -var-file=main.tfvars -out=tfplan -input=false"
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