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
        stage('Ejecución de pruebas') {
            steps {
                sh 'npm test'      // o mvn test / pytest
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

    }
}
