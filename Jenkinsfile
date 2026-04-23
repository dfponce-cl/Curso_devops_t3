pipeline{
    agent {
        docker
            {
                image "docker:24"
            
            }
    }
    stages{
        stage('Integración'){
            steps{
                echo 'install...'
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
