pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = 'true'
        TF_CLI_ARGS = '-no-color'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        SSH_CRED_ID = 'aws-deployer-ssh-key'
    }

    stages {
        stage('Terraform Initialization') {
            steps {
                sh 'terraform init'
                def branch = env.BRANCH_NAME ?: "main"
                sh "cat ${env.BRANCH_NAME}.tfvars"
            }
        }

        stage('Terraform Plan') {
            steps {
                def branch = env.BRANCH_NAME ?: "main"
                sh "terraform plan -var-file=${env.BRANCH_NAME}.tfvars -out=tfplan"
            }
        }

        stage('Validate Apply') {
            when {
                branch 'dev' 
            }
            steps {
                input message: "Does the plan for ${env.BRANCH_NAME} look correct?", ok: "Approve"
            }
        }
        
        stage('Terraform Apply') {
            when { branch 'dev' }
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}