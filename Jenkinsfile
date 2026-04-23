pipeline{
    agent {
        docker
            {
                image "node:24"
                reuseNode true 
            }
    }
    stages{
        stage('Dependencias ..') {
            steps{
                sh "npm install"
                sh "ls -l"
                sh "hostname"
            }
        }
        stage('Ejecución de pruebas') {
            steps {
                sh "npm run test"      // o mvn test / pytest
            }
        }
        stage("CI de la aplicacion - build") {
            steps {
                sh "npm run build"
            }
        }   
        stage("Quality Assurance") {
            agent {
                docker {
                    image 'sonarsource/sonar-scanner-cli'
                    args '--network=devops-infra_default'
                    reuseNode true
                }
            }
        }
    }
}
