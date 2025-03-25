pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1'
        TF_WORKING_DIR = 'terraform'
        TF_STATE_FILE = 'terraform/terraform.tfstate'
        ANSIBLE_HOST_KEY_CHECKING = 'False'
    }

    stages {
        stage('User Input') {
            steps {
                script {
                    env.USER_ACTION = input message: 'Select Action:', parameters: [
                        choice(name: 'ACTION', choices: ['Build', 'Destroy'], description: 'Choose whether to build or destroy infrastructure')
                    ]
                    echo "User selected action: ${env.USER_ACTION}"
                }
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/aditya8838/ES-Kibana-OCI.git'
            }
        }

        stage('Run GitLeaks Security Scan') {
            steps {
                sh '''
                echo "🔍 Running GitLeaks security scan..."
                /usr/local/bin/gitleaks detect -v --source . --exit-code 1
                '''
            }
        }

        stage('Terraform Init') {
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.USER_ACTION == 'Build' }
            }
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { env.USER_ACTION == 'Destroy' }
            }
            steps {
                dir(TF_WORKING_DIR) {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }

        stage('Input for Installing Application') {
            when {
                expression { env.USER_ACTION == 'Build' }
            }
            steps {
                script {
                    env.INSTALL_ACTION = input message: 'Infrastructure built successfully. Choose to install or skip.', parameters: [
                        choice(name: 'INSTALL_ACTION', choices: ['Install', 'Skip'], description: 'Install ES & kibana or Skip')
                    ]
                }
            }
        }

        stage('Wait for Instances (if Install)') {
            when {
                expression { env.INSTALL_ACTION == 'Install' }
            }
            steps {
                echo "⏳ Waiting for EC2 instances to be ready..."
                sleep(time: 60, unit: 'SECONDS')
            }
        }

        stage('Check Ansible Inventory') {
            when {
                expression { env.INSTALL_ACTION == 'Install' }
            }
            steps {
                sh '''
                cd ansible
                # Install boto3 on Jenkins node first
                pip3 install boto3 --quiet
                
                # Make sure inventory script is executable
                chmod +x dynamic_inventory.py
                
                # Test the inventory script directly
                python3 dynamic_inventory.py --list
                
                # Verify with ansible-inventory
                ansible-inventory -i dynamic_inventory.py --list
                '''
            }
        }

        stage('Install Dependencies on Managed Nodes') {
            when {
                expression { env.INSTALL_ACTION == 'Install' }
            }
            steps {
                script {
                    // Create SSH directory if it doesn't exist
                    sh '''
                    mkdir -p ~/.ssh
                    chmod 700 ~/.ssh
                    touch ~/.ssh/known_hosts
                    chmod 600 ~/.ssh/known_hosts
                    '''
                    
                    // Get hosts from inventory
                    def hosts = sh(script: '''
                        cd ansible
                        python3 dynamic_inventory.py --list | jq -r '.elasticsearch.hosts[]'
                    ''', returnStdout: true).trim().split('\n')
                    
                    // Wait for SSH to be available on all hosts
                    def sshReady = false
                    while (!sshReady) {
                        sshReady = true
                        hosts.each { host ->
                            def status = sh(script: """
                                if nc -zv -w 5 ${host} 22; then
                                    ssh-keyscan ${host} >> ~/.ssh/known_hosts
                                    echo "ready"
                                else
                                    echo "not ready"
                                fi
                            """, returnStatus: true)
                            
                            if (status != 0) {
                                sshReady = false
                                echo "Host ${host} not ready for SSH"
                            }
                        }
                        
                        if (!sshReady) {
                            sleep(30)
                        }
                    }
                    
                    // Install dependencies
                    sh '''
                    cd ansible
                    ansible all -i dynamic_inventory.py -m raw \
                      -a "apt update -y && apt install -y python3 python3-pip python3-six" \
                      --become \
                      -u ubuntu \
                      --private-key=~/.ssh/your-key.pem \
                      -e ansible_ssh_common_args='-o StrictHostKeyChecking=no'
                    '''
                }
            }
        }
        stage('Run Ansible Playbook') {
            when {
                expression { env.INSTALL_ACTION == 'Install' }
            }
            steps {
                sh '''
                cd ansible
                ansible-playbook site.yml
                '''
            }
        }
    }

    post {
        success {
            script {
                def emailBody = """
                <html>
                    <body style="font-family: Arial, sans-serif; background-color: #F4F4F4; padding: 20px;">
                        <div style="max-width: 600px; margin: auto; background-color: #D4EDDA; padding: 20px; border-left: 5px solid #28A745; border-radius: 5px;">
                            <h2 style="color: #155724;">✅ Jenkins Job SUCCESS</h2>
                            <p style="color: #155724; font-size: 16px;">
                                <strong>Job Name:</strong> ${env.JOB_NAME} <br>
                                <strong>Build No:</strong> ${env.BUILD_NUMBER} <br>
                                <strong>Triggered By:</strong> ${currentBuild.getBuildCauses().shortDescription}
                            </p>
                            <p style="color: #155724; font-size: 16px;"><strong>Check logs here:</strong>
                                <a href="${env.BUILD_URL}" style="color:#155724; text-decoration:none; font-weight:bold;">Click Here To View Build Logs</a>
                            </p>
                        </div>
                    </body>
                </html>
                """
                emailext(
                    mimeType: 'text/html',
                    subject: "✅ SUCCESS: ${env.JOB_NAME} (Build #${env.BUILD_NUMBER})",
                    body: emailBody,
                    to: 'adityatripathi022@gmail.com'
                )
            }
        }

        failure {
            script {
                def emailBody = """
                <html>
                    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
                        <div style="max-width: 600px; margin: auto; background-color: #f8d7da; padding: 20px; border-left: 5px solid #dc3545; border-radius: 5px;">
                            <h2 style="color: #721c24;">❌ Jenkins Job FAILED</h2>
                            <p style="color: #721c24; font-size: 16px;">
                                <strong>Job Name:</strong> ${env.JOB_NAME} <br>
                                <strong>Build No:</strong> ${env.BUILD_NUMBER} <br>
                                <strong>Triggered By:</strong> ${currentBuild.getBuildCauses().shortDescription}
                            </p>
                            <p style="color: #721c24; font-size: 16px; font-weight: bold;">The job has failed. ❌</p>
                            <p style="color: #721c24; font-size: 16px;"><strong>Check logs here:</strong>
                                <a href="${env.BUILD_URL}" style="color:#155724; text-decoration:none; font-weight:bold;">Click Here To View Build Logs</a>
                            </p>
                        </div>
                    </body>
                </html>
                """
                emailext(
                    mimeType: 'text/html',
                    subject: "❌ FAILED: ${env.JOB_NAME} (Build #${env.BUILD_NUMBER})",
                    body: emailBody,
                    to: 'adityatripathi022@gmail.com'
                )
            }
        }
    }
}
