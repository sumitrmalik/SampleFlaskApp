pipeline {
    agent any

    stages {
        stage('Deployment') {
            steps {
                sh 'docker stop webos || true'
                sh 'docker rm webos || true'
                sh 'docker pull sumitrmalik/gfg27img'
                sh 'docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
