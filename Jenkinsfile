pipeline {
    agent {
        label "ec2"
    }

    stages {
        stage('Debug Docker Environment') {
            steps {
                sh 'echo "Current user for Jenkins agent:"'
                sh 'whoami'
                sh 'echo "Groups for Jenkins agent user:"'
                sh 'groups'
                sh 'echo "PATH for Jenkins agent:"'
                sh 'echo $PATH'
                sh 'echo "Trying to locate docker:"'
                sh 'which docker || echo "which docker failed!"'
                sh 'echo "Trying to execute docker with full path (assuming /usr/bin/docker):"'
                sh '/usr/bin/docker --version || echo "Failed to run /usr/bin/docker"'
            }
        }
        stage('Deployment') {
            steps {
                sh '/usr/bin/docker stop webos || true'
                sh '/usr/bin/docker rm webos || true'
                sh '/usr/bin/docker pull sumitrmalik/gfg27img'
                sh '/usr/bin/docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
