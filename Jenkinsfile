pipeline {
    agent {
        label "ec2"
    }

    stages {
        // Keep the debug stage for one more run
        stage('Debug Environment (Absolute Paths)') {
            steps {
                sh 'echo "Current user for Jenkins agent:"'
                sh 'whoami'
                sh 'echo "Groups for Jenkins agent user:"'
                sh 'groups'
                sh 'echo "PATH for Jenkins agent:"'
                sh 'echo $PATH'
                sh 'echo "Trying to locate sudo using which:"'
                sh 'which sudo || echo "which sudo failed!"'
                sh 'echo "Trying to execute sudo with full path (assuming /usr/bin/sudo):"'
                sh '/usr/bin/sudo --version || echo "Failed to run /usr/bin/sudo"'
                sh 'echo "Trying to locate docker using which:"'
                sh 'which docker || echo "which docker failed!"'
                sh 'echo "Trying to execute docker with full path (assuming /usr/bin/docker):"'
                sh '/usr/bin/docker --version || echo "Failed to run /usr/bin/docker"'
            }
        }
        stage('Deployment') {
            steps {
                // Use absolute path for sudo, and for docker
                sh '/usr/bin/sudo /usr/bin/docker stop webos || true'
                sh '/usr/bin/sudo /usr/bin/docker rm webos || true'
                sh '/usr/bin/sudo /usr/bin/docker pull sumitrmalik/gfg27img'
                sh '/usr/bin/sudo /usr/bin/docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
