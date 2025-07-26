pipeline {
    agent {
        label "ec2"
    }

    stages {
        // Keep the debug stage for one more run to confirm our assumptions
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
                // Use sudo for docker commands
                sh 'sudo /usr/bin/docker stop webos || true'
                sh 'sudo /usr/bin/docker rm webos || true'
                sh 'sudo /usr/bin/docker pull sumitrmalik/gfg27img'
                sh 'sudo /usr/bin/docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
