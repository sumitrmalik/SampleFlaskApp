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
                sh 'groups' // This will show the numeric GID 992 now.
                sh 'echo "PATH for current user:"'
                sh 'echo $PATH'
                sh 'echo "--- Checking Docker Socket inside container ---"'
                sh 'ls -l /var/run/docker.sock || echo "Docker socket not found or permission denied at /var/run/docker.sock"'
                sh 'echo "--- Trying to locate Docker client binary ---"'
                sh 'find / -name "docker" -type f -executable 2>/dev/null || echo "Docker client executable not found anywhere"' // Search for executable 'docker'
                sh 'echo "--- Trying to execute Docker client by absolute path (assuming common location) ---"'
                sh '/usr/bin/docker version || echo "/usr/bin/docker not found or executable"'
                sh '/usr/local/bin/docker version || echo "/usr/local/bin/docker not found or executable"'
                sh 'echo "--- Trying to access Docker info ---"'
                sh 'docker info || echo "docker info failed!"' // This might still fail with 'not found'
                sh 'echo "--- Trying to run a simple Docker command ---"'
                sh 'docker ps -a || echo "docker ps failed!"' // This might still fail with 'not found'
            }
        }
        stage('Deployment') {
            steps {
                // Keep 'docker' as is; the goal is for the debug stage to fix it
                sh 'docker stop webos || true'
                sh 'docker rm webos || true'
                sh 'docker pull sumitrmalik/gfg27img'
                sh 'docker run -dit --name webos -p 81:80 sumitrmalik/gfg27img'
            }
        }
    }
}
