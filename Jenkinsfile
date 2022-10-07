pipeline {
    agent any
    
    tools
    {
       maven "Maven"
    }
     
    stages {
      stage('checkout') {
           steps {
             
                git branch: 'master', url: 'https://github.com/Ngazoa/BestSotock.git'
             
          }
        }
         stage('Tools Init') {
            steps {
                script {
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
               def tfHome = tool name: 'Ansible'
                env.PATH = "${tfHome}:${env.PATH}"
                 sh 'ansible --version'
                    
            }
            }
        }
     
        
         stage('Execute Maven') {
           steps {
             
                sh 'mvn package'             
          }
        }
          stage('create Docker Image') {
                    steps {
                        script {
                            dockerImage = docker.build imageTag
                        }
                    }
                }
        stage('Push docker Image to registry'){
            environment {
                registryCredential = 'dockerhub_Id'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("latest")
                    }
                }
            }
        }
        //******************* ************************** Kubernetes Deploy *********************
//         stage('Deploying Stock app on kubernetes  Cluster') {
//             steps {
//                 script{
//                     kubernetesDeploy(configs: "deployment.yaml", kubeconfig: "kubernetesId")
//
//                 }
//             }
//         }

        stage('Ansible Deploy') {
             
            steps {

               sh "ansible-playbook main.yml -i inventories/dev/hosts --user jenkins --key-file ~/.ssh/id_rsa"

            }
        }
    }
}
