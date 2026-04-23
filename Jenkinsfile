pipeline{
    agent {
        docker
            {
                image "docker:24"
                args "-v /var/run/docker.sock:/var/run/docker.sock"    
            }
    }
    stages{
        stage('Dependencias ..'){
            steps{
                sh "npm install"
                sh "ls -l"
                sh "hostname"
            }
        }
        stage('Test'){
            steps{
                echo 'Testing...'
            }
        }
        stage('Deploy'){
            steps{
                echo 'Deploying...'
            }
        }
    }
}
