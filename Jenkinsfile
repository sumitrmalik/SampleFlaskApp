pipeline {
    agent {
        label "ec2"
    }

    stages {
        stage('Downloading the source code') {
            steps {
                git branch: 'main', credentialsId: 'github-sumitrmalik-pat', url: 'https://github.com/sumitrmalik/SampleFlaskApp.git'
                echo 'code downloaded successfully'
            }
        }

        stage('Test') {
            steps {
                // Consider moving yum install into Dockerfile or ensuring agent setup
                sh 'sudo yum install unzip -y' // This should only be needed once on the agent
                sh 'yum install python3-pip -y' // This should only be needed once on the agent
                sh 'pip3 install -r requirements.txt' // This installs on the agent, consider doing it in Dockerfile
                sh 'pytest'
                echo "Code has been successfully tested."
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t gfgwebimg .'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner';
                    withSonarQubeEnv('SonarQubeServer') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Deployment') {
            steps {
                // Make stop/rm idempotent
                sh 'docker stop webos || true'
                sh 'docker rm webos || true'
                // Add memory limit if needed
                sh 'docker run -dit --name webos -p 80:80 -m 2000m gfgwebimg' // Add -m 2000m if you want to enforce memory limit
            }
        }
    }
}
