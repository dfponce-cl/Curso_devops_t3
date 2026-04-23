pipeline{
    agent {
        docker
            {
                image "node:24"
                reuseNode true 
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
