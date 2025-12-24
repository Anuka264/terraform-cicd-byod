pipeline {
    agent any
    environment {
        TF_IN_AUTOMATION = 'true'
        TF_CLI_ARGS = '-no-color'
        AWS_ACCESS_KEY_ID = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        // FIX: This line ensures we don't get 'null.tfvars'
        TARGET_BRANCH = "${env.BRANCH_NAME ?: 'main'}"
    }

    stages {
        stage('Terraform Initialization') {
            steps {
                sh 'terraform init'
                // Task 3: Variable Inspection
                sh "cat ${env.TARGET_BRANCH}.tfvars"
            }
        }

        stage('Terraform Plan') {
            steps {
                // Task 4: Plan with branch-specific vars
                sh "terraform plan -var-file=${env.TARGET_BRANCH}.tfvars -out=tfplan"
            }
        }

        stage('Validate Apply') {
            when { 
                // Task 5: Gate only triggers on 'dev' branch
                expression { env.TARGET_BRANCH == 'dev' } 
            }
            steps {
                input message: "Approve deployment for ${env.TARGET_BRANCH}?", ok: "Approve"
            }
        }
        
        stage('Terraform Apply') {
            when { expression { env.TARGET_BRANCH == 'dev' } }
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
}