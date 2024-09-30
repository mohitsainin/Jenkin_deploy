pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select action: apply or destroy')
    }
    environment {
        TERRAFORM_WORKSPACE = "/var/lib/jenkins/workspace/tool_deploy/Jenkins-infra/"
        INSTALL_WORKSPACE = "/var/lib/jenkins/workspace/tool_deploy/Jenkins/"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/mohitsainin/Jenkin_deploy.git'
            }
        }
      stage('Terraform init') {
            steps {
                sh 'terraform init -upgrade'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    if (params.action == 'apply') {
                        if (!params.autoApprove) {
                            def plan = readFile 'tfplan.txt'
                            input message: "Do you want to apply the plan?",
                            parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        }
                        sh 'terraform apply -input=false tfplan'
                    } else if (params.action == 'destroy') {
                        sh 'terraform destroy --auto-approve'
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                dir('/var/lib/jenkins/workspace/jenkins_Automation') {
                    sh 'pwd'
                sh 'ansible-playbook -i aws_ce2.yml test.yml'
                    
                }
            }
        }
    }
}
     
