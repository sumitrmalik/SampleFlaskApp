pipeline {
    agent {
        label "ec2"
    }

    stages {
        stage('Downloading the source code - job1') {
            steps {
                git branch: 'main', credentialsId: 'github-sumitrmalik-pat', url: 'https://github.com/sumitrmalik/SampleFlaskApp.git'
                echo 'code downloaded successfully'
            }
        }
        
        stage('Test - job2'){
            steps {
                sh 'yum install python3-pip -y'
                sh 'pip3 install -r requirements.txt'
                sh 'pytest'
                echo "Code have been successfully tested."
            }
        }
        
        stage('Build Docker Image - job3') {
            steps {
                sh 'docker build -t gfgwebimg .'
            }
        }
        
        stage('Deployment - job4') {
            steps {
                sh 'docker stop webos'
                sh 'docker rm webos'
                sh 'docker run -dit --name webos -p 80:80 gfgwebimg'
            }
        }
    }
}
