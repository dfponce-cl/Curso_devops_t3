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
                sh "npm run test"      // o mvn test / pytest
            }
        }
        stage("CI de la aplicacion - build") {
            steps {
                sh "npm run build"
            }
        }
    }
    stage("Quality Assurance"){
        agent {
            docker {
                image 'sonarsource/sonar-scanner-cli'
                args '--network=devops-infra_default'
                reuseNode true
            }
        }
        stages{
            stage("validacion de codigo"){
                steps{
                    withSonarQubeEnv('sonarqube'){
                        sh 'sonar-scanner'
                    }
                }
            }
            stage('validacion quality gate'){
                steps{
                    script{
                        def  qualityGate = waitForQualityGate() // esperar por el resultado del qualitygate en un endpoint de jenkins, que se gatilla desde sonar via webhook.
                        if(qualityGate.status != 'OK'){
                             error "La puerta de calidad ha fallado : ${qualityGate.status}"
                        }
                    }
                }
            }
        }
    }

}