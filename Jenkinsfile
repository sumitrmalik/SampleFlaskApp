pipeline {
    agent {
        label "ec2"
    }

    stages {
        stage('Final Docker Debug') {
            steps {
                sh 'echo "Current user:"'
                sh 'whoami'
                sh 'echo "Groups for current user:"'
                sh 'groups'
                sh 'echo "PATH for current user:"'
                sh 'echo $PATH'
                sh 'echo "--- Checking Docker Socket inside container ---"'
                sh 'ls -l /var/run/docker.sock || echo "Docker socket not found or permission denied at /var/run/docker.sock"'
                sh 'echo "--- Trying to access Docker info ---"'
                sh 'docker info || echo "docker info failed!"'
                sh 'echo "--- Trying to run a simple Docker command ---"'
                sh 'docker ps -a || echo "docker ps failed!"'
            }
        }
        stage('Deployment') {
            steps {
                // Revert to simple 'docker' as the socket should give access
                sh 'docker stop webos || true'
                sh 'docker rm webos || true'
                sh 'docker pull sumitrmalik/gfg27img'
                sh 'docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
