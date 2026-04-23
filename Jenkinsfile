pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        //GITHUB_PACKAGES_CREDENTIALS = credentials('github-packages-creds')
        GITHUB_TOKEN = credentials('github-pat')
        IMAGE_NAME = "tuusuario/curso-devops-lab3"
        VERSION = "1.0.0"
    }

    stages {
        stage('Instalación de dependencias ') {
            steps {
                sh "echo 'install'"  
                sh "npm install"  
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

        stage('Quality Gate') {
            steps {
                timeout(time: 5, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Build de aplicación') {
            steps {
                sh 'npm run build'   // o mvn package / gradle build
            }
        }
/*
        stage('Docker Build Multistage') {
            steps {
                script {
                    sh """
                    docker build -t $IMAGE_NAME:latest \
                                 -t $IMAGE_NAME:${VERSION} \
                                 -t $IMAGE_NAME:${BUILD_NUMBER} .
                    """
                }
            }
        }

        stage('Push a DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        sh "docker push $IMAGE_NAME:latest"
                        sh "docker push $IMAGE_NAME:${VERSION}"
                        sh "docker push $IMAGE_NAME:${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Push a GitHub Packages') {
            steps {
                script {
                    docker.withRegistry('https://docker.pkg.github.com', GITHUB_PACKAGES_CREDENTIALS) {
                        sh "docker tag $IMAGE_NAME:latest docker.pkg.github.com/tuorg/curso-devops-lab3:latest"
                        sh "docker tag $IMAGE_NAME:${VERSION} docker.pkg.github.com/tuorg/curso-devops-lab3:${VERSION}"
                        sh "docker tag $IMAGE_NAME:${BUILD_NUMBER} docker.pkg.github.com/tuorg/curso-devops-lab3:${BUILD_NUMBER}"

                        sh "docker push docker.pkg.github.com/tuorg/curso-devops-lab3:latest"
                        sh "docker push docker.pkg.github.com/tuorg/curso-devops-lab3:${VERSION}"
                        sh "docker push docker.pkg.github.com/tuorg/curso-devops-lab3:${BUILD_NUMBER}"
                    }
                }
            }
        }

        stage('Actualizar Kubernetes local') {
            steps {
                sh "kubectl set image deployment curso-devops-lab3 curso-devops-lab3=$IMAGE_NAME:${BUILD_NUMBER} -n dponce"
                sh "kubectl rollout status deployment curso-devops-lab3 -n dponce"
            }
        }*/
    }
}