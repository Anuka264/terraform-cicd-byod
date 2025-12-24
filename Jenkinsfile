pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'us-east-1'
    }
    stages {
        stage('Task 1: Provisioning') {
            steps {
                script {
                    sh 'terraform init'
                    sh 'terraform apply -var-file=main.tfvars -auto-approve'
                }
            }
        }
        stage('Task 2: Inventory Management') {
            steps {
                withCredentials([file(credentialsId: 'aws-deployer-ssh-key', variable: 'KEY_FILE')]) {
                    script {
                        def public_ip = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()
                        sh "mkdir -p keys_33"
                        sh "cp ${KEY_FILE} keys_33/demo1.pem"
                        sh "chmod 400 keys_33/demo1.pem"
                        writeFile file: 'dynamic_inventory.ini', text: "[splunk_servers]\n${public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=keys_33/demo1.pem"
                    }
                }
            }
        }
        stage('Task 3: Health Verification') {
            steps {
                script {
                    def instance_id = sh(script: "terraform output -raw instance_id", returnStdout: true).trim()
                    sh "aws ec2 wait instance-status-ok --instance-ids ${instance_id} --region us-east-1"
                    echo "Instance is healthy and ready for Splunk install!"
                }
            }
        }
        stage('Task 4: Splunk Install') {
            steps {
                script {
                    sh 'sleep 30'
                    ansiblePlaybook playbook: 'playbooks/splunk.yml', inventory: 'dynamic_inventory.ini'
                }
            }
        }
    }
}