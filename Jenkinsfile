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

        stage('Test') { // Renamed for clarity
            steps {
                // Consider moving yum install into Dockerfile or ensuring agent setup
                sh 'sudo yum install unzip -y'
                sh 'yum install python3-pip -y' 
                sh 'pip3 install -r requirements.txt'
                sh 'pytest'
                echo "Code has been successfully tested."
            }
        }

        stage('Build Docker Image') { // Renamed for clarity
            steps {
                sh 'docker build -t gfgwebimg .'
            }
        }

        stage('SonarQube Analysis') { // NEW STAGE
            steps {
                script { // Use script block for scripted steps within declarative
                    def scannerHome = tool 'SonarScanner';
                    withSonarQubeEnv('SonarQubeServer ') { // Replace with your SonarQube server ID configured in Jenkins
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Deployment') { // Renamed for clarity
            steps {
                // Make stop/rm idempotent
                sh 'docker stop webos || true'
                sh 'docker rm webos || true'
                // Add memory limit if needed
                sh 'docker run -dit --name webos -p 80:80 gfgwebimg' // Add -m 2000m if you want to enforce memory limit
            }
        }
    }
}
