pipeline {
    environment {
        dockerImagename = "stock-Devops"
        dockerImage = ""
    }

    agent any
    tools{
        maven '3.8.6'
        'org.jenkinsci.plugins.docker.commons.tools.DockerTool' 'docker'
    }
    stages {
        stage('create and build maven project'){
            steps{
                script{
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'jenkinsserviceaccount', url: 'https://github.com/Ngazoa/BestSotock.git']]])
               //sh 'mvn clean install'
                }
            }
        }
//        stage('load git stock repository') {
//            steps {
//                git 'https://github.com/Ngazoa/BestSotock.git'
//            }
//        }



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
    