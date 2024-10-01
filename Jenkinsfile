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
                dir("${TERRAFORM_WORKSPACE}") {
                    sh 'terraform init -upgrade'
                }
            }
        }
        stage('Plan') {
            steps {
                dir("${TERRAFORM_WORKSPACE}") {
                    sh 'terraform plan -out tfplan'
                    sh 'terraform show -no-color tfplan > tfplan.txt'
                }
            }
        }
        stage('Apply / Destroy') {
            steps {
                script {
                    if (params.ACTION == 'apply') {
                        def plan = readFile("${TERRAFORM_WORKSPACE}/tfplan.txt")
                        input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                        dir("${TERRAFORM_WORKSPACE}") {
                            sh 'terraform apply -input=false tfplan'
                        }
                    } else if (params.ACTION == 'destroy') {
                        dir("${TERRAFORM_WORKSPACE}") {
                            sh 'terraform destroy --auto-approve'
                        }
                    } else {
                        error "Invalid action selected. Please choose either 'apply' or 'destroy'."
                    }
                }
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                dir("${INSTALL_WORKSPACE}") {
                    sh 'ansible-playbook -i aws_ce2.yml playbook.yml'
                }
            }
        }
    }
}
