pipeline {
    agent {
        label "ec2"
    }

    stages {
        stage('Deployment') {
            steps {
                sh 'sudo docker stop webos || true'
                sh 'sudo docker rm webos || true'
                sh 'sudo docker pull sumitrmalik/gfg27img'
                sh 'sudo docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
