pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        TF_IN_AUTOMATION      = 'true'
    }

    stages {
        stage('Task 1: Provisioning') {
            steps {
                script {
                    sh 'terraform init'
                    sh "terraform apply -var-file=main.tfvars -auto-approve"
                    env.INSTANCE_IP = sh(script: "terraform output -raw instance_public_ip", returnStdout: true).trim()
                    env.INSTANCE_ID = sh(script: "terraform output -raw instance_id", returnStdout: true).trim()
                }
            }
        }

        stage('Task 2: Inventory Management') {
    steps {
        withCredentials([file(credentialsId: 'splunk-ssh-key', variable: 'KEY_FILE')]) {
            script {
                // 1. Create a brand new, unique folder name using the Build Number
                // This ensures we NEVER hit a permission conflict with old files
                def uniqueFolder = "${WORKSPACE}/keys_${BUILD_NUMBER}"
                sh "mkdir -p ${uniqueFolder}"
                
                // 2. Copy to the unique folder
                sh "cp ${KEY_FILE} ${uniqueFolder}/demo1.pem"
                sh "chmod 400 ${uniqueFolder}/demo1.pem"
                
                // 3. Create the inventory pointing to this unique path
                def content = "[splunk_servers]\n${env.INSTANCE_IP} ansible_user=ubuntu ansible_ssh_private_key_file=${uniqueFolder}/demo1.pem"
                writeFile file: 'dynamic_inventory.ini', text: content
                
                sh "cat dynamic_inventory.ini"
            }
        }
    }
}
        

        stage('Task 3: Health Verification') {
            steps {
                sh "aws ec2 wait instance-status-ok --instance-ids ${env.INSTANCE_ID} --region us-east-1"
                echo "Instance is healthy and ready for Splunk install!"
            }
        }

        stage('Task 4: Splunk Install') {
            steps {
                script {
                    withEnv(["ANSIBLE_HOST_KEY_CHECKING=False"]) {
                        ansiblePlaybook(
                        playbook: 'playbooks/splunk.yml', 
                        inventory: 'dynamic_inventory.ini'
                        )
                    }
                }
            }
        }

        stage('Task 5: Cleanup Gate') {
            steps {
                input message: "Destroy Infrastructure?"
                sh "terraform destroy -var-file=main.tfvars -auto-approve"
            }
        }
    }
}