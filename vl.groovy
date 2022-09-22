pipeline {
    environment {
        dockerImagename = "stock/gitimage"
        dockerImage = ""
    }
    agent any

    stages {
        stage('load git stock repository') {
            steps {
                git 'https://github.com/Ngazoa/BestSotock.git'
            }
        }



        stage('create Docker Image') {
            steps {
                script {
                    dockerImage = docker.build dockerImagename
                }
            }
        }


    stage('Push docker Image'){
        environment {
            registryCredential = 'dockerStockImage'
        }
        steps {
            script {
                docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    dockerImage.push("latest")
                }
            }
        }
    }
    stage('Deploying Stock app on kubernetes ') {
        steps {

            kubernetsDeploy(configs: "Deployment.yaml", kubeconfig: "kubernetId")
        }
    }
}
}
    