// Una funcion en un jenkins file Se escribe como cualquier funcion. Tiene un nombre, 
// y parametros y comienza con la palabra reservada def. Esta funcion se llama tagAndPush
// y sirve para resumir la logica de upload de imagenes sin repetir el que teniamos antes.

def tagAndPush(String localImage, String repo, String registry, String credential) {

    docker.withRegistry(registry, credential) {
        sh "docker tag ${localImage} ${repo}:latest"
        sh "docker tag ${localImage} ${repo}:${env.BUILD_NUMBER}"
        sh "docker tag ${localImage} ${repo}:${env.APP_SEMANTIC_VERSION}"
        sh "docker push ${repo}:latest"
        sh "docker push ${repo}:${env.BUILD_NUMBER}"
        sh "docker push ${repo}:${env.APP_SEMANTIC_VERSION}"
    }

}

pipeline {
    agent any
    // Aca podemos declarar variables que luego podemos acceder como variables de ambiente dentro del pipeline
    // usando "env.". Estas variables solo existen en este pipeline.
    environment {
        IMAGE_NAME = "curso-devops"
        DH_REPO    = "carlosmarind/curso-devops"
        GHCR_REPO  = "ghcr.io/carlosmarind/curso-devops"
        K8S_NAMESPACE  = "curso"
        K8S_DEPLOYMENT = "curso-devops-deployment"
        K8S_CONTAINER  = "contenedor-curso-devops"



    }
    stages {
        stage("Integracion continua") {
            agent {
                docker {
                    image "node:24"
                    reuseNode true
                }
            }
            stages {
                stage("CI de la aplicacion - version") {
                    steps {
                        script {
                            env.APP_SEMANTIC_VERSION = sh(
                                script: 'npm pkg get version | tr -d \'"\'',
                                returnStdout: true
                            ).trim()
                            echo "Version semantica detectada: ${env.APP_SEMANTIC_VERSION}"
                        }
                    }
                }
                stage("CI de la aplicacion - dependencias") {
                    steps {
                        sh "npm install"
                    }
                }
                stage("CI de la aplicacion - lint") {
                    steps {
                        sh "npm run lint"
                    }
                }
                stage("CI de la aplicacion - test") {
                    steps {
                        sh "npm run test:cov"
                    }
                }
                stage("CI de la aplicacion - build") {
                    steps {
                        sh "npm run build"
                    }
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
}