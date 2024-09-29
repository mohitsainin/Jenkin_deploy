pipeline { 
    agent any 
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
        choice(name: 'TAGS', choices: ['install', 'uninstall'], description: 'Select tags: install or uninstall')
        choice(name: 'OS', choices: ['ubuntu', 'redhat'], description: 'Select OS family: ubuntu or redhat')
    }
    stages { 
        stage('git checkout') { 
          steps {  
            checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/mohitsainin/Jenkin_deploy.git']])            } 
        } 
        stage('terraform init'){ 
            steps { 
                sh 'terraform init'  
            } 
        } 
        stage('terraform plan'){ 
            steps { 
                sh 'terraform plan'  
            } 
        }
        stage('apply Approval'){ 
            when {
                expression { params.ACTION == 'apply' }
            }
            steps { 
                input message: 'Verify infra. plan before appliction?', ok: 'Yes' 
            } 
        } 
        stage('terraform apply'){
            when {
                expression { params.ACTION == 'apply' }
            } 
            steps { 
                sh 'terraform apply --auto-approve' 
                sh 'terraform output '     
            } 

        }
        stage('Store EFS and ALB DNS Name'){
            when {
                expression { params.ACTION == 'apply' }
            }
            steps{
                    script {
                    def efsDnsName = sh(
                        returnStdout: true,
                        script: 'terraform output efs_dns_name').trim()
                    def albDnsName = sh(
                        returnStdout: true,
                        script: 'terraform output jenkins_alb_dns_name').trim()
                    env.EFS_DNS_NAME = efsDnsName
                    env.ALB_DNS_NAME = albDnsName
                    }
                    
                }
        }
        stage('Print DNS Name'){
            when {
                expression { params.ACTION == 'apply' }
            }
            steps{
                    sh """
                        echo ${env.EFS_DNS_NAME} 
                        echo ${env.ALB_DNS_NAME}
                    """
                }
        }

        stage('Running Ansible') {
            when {
                expression { params.ACTION == 'apply' }
            }
            parallel {
                stage('Ansible Graph') {                  
                    steps {
                        sh "ansible-inventory --graph"
                    }
                }
                stage('Install Jenkins On Ubuntu') {
                    when {
                        expression { 
                            params.TAGS == 'install' && (params.OS == 'ubuntu') 
                        }
                    }                    
                    steps {
                        sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu  ${WORKSPACE}/master.yml --extra-vars \"efs_mount_point=${env.EFS_DNS_NAME}\" --tags \"install\"" 
                    }
                }
                stage('Uninstall Jenkins On Ubuntu') {
                    when {
                        expression { 
                            params.TAGS == 'uninstall' && (params.OS == 'ubuntu') 
                        }
                    }  
                    steps {
                        sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu  ${WORKSPACE}/master.yml --extra-vars \"efs_mount_point=${env.EFS_DNS_NAME}\" --tags \"uninstall\"" 
                    }
                }
                stage('Install Jenkins On RedHat') {
                    when {
                        expression { 
                            params.TAGS == 'install' && (params.OS == 'redhat') 
                        }
                    }  
                    steps {
                        sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user  ${WORKSPACE}/master.yml --extra-vars \"efs_mount_point=${env.EFS_DNS_NAME}\" --tags \"install\"" 
                    }
                }
                stage('Uninstall Jenkins On RedHat') {
                    when {
                        expression { 
                            params.TAGS == 'uninstall' && (params.OS == 'redhat') 
                        }
                    }  
                    steps {
                        sh "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user  ${WORKSPACE}/master.yml --extra-vars \"efs_mount_point=${env.EFS_DNS_NAME}\" --tags \"uninstall\"" 
                    }
                }

            }
        }
        stage('destroy Approval'){ 
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps { 
                input message: 'Do you want to destroy the applied infra?', ok: 'Yes' 
            } 
        } 
        stage('terraform destroy'){ 
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps { 
                sh 'terraform destroy --auto-approve'  
            } 
        }
    } 
}
