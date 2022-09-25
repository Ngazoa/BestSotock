node{

def WORKSPACE="/var/lib/jenkins/workspace/springboot-deploy"
def dockerImageTag="springboot-deploy${env.BUILD_NUMBER}"



//       stage('Buid Docker Image '){
//            dockerImage=docker.build("springboot-deploy:${env.BUILD_NUMBER}")
//       }
//       stage('Deploy image on Docker'){
//         echo'Deployment image docker name ${dockerImage}'
//         sh("docker stop springboot-deploy || true && docker rm springboot-deploy || true")
//         sh("docker run --name springboot-deploy -d -p 5000:8080 springboot-deploy${env.BUILD_NUMBER}")
//       }





  //Define all variables
  def project = 'my-project'
  def appName = 'my-first-microservice'
  def serviceName = "${appName}-backend"
  def imageVersion = 'development'
  def namespace = 'development'
  def imageTag = "gcr.io/${project}/${appName}:${imageVersion}.${env.BUILD_NUMBER}"

  //Checkout Code from Git
  checkout scm

  //Stage 1 : Build the docker image.
//   stage('Initialize'){
//           def dockerHome = tool 'mydocker'
//           env.PATH = "${dockerHome}/bin:${env.PATH}"
//       }

stage("Git Clone Repository"){
         git url:'https://github.com/Ngazoa/BestSotock.git'
         credentielsId:'springboot-deploy-user'
         branch:'master'
      }
  stage('Build image jenKINNNS') {
      sh("docker build -t ${imageTag} .")
  }

  //Stage 2 : Push the image to docker registry
  stage('Push image to registry') {
      sh("gcloud docker -- push ${imageTag}")
  }

  //Stage 3 : Deploy Application
  stage('Deploy Application') {
       switch (namespace) {
              //Roll out to Dev Environment
              case "development":
                   // Create namespace if it doesn't exist
                   sh("kubectl get ns ${namespace} || kubectl create ns ${namespace}")
           //Update the imagetag to the latest version
                   sh("sed -i.bak 's#gcr.io/${project}/${appName}:${imageVersion}#${imageTag}#' ./k8s/development/*.yaml")
                   //Create or update resources
           sh("kubectl --namespace=${namespace} apply -f k8s/development/deployment.yaml")
                   sh("kubectl --namespace=${namespace} apply -f k8s/development/service.yaml")
           //Grab the external Ip address of the service
                   sh("echo http://`kubectl --namespace=${namespace} get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
                   break

        //Roll out to Dev Environment
              case "production":
                   // Create namespace if it doesn't exist
                   sh("kubectl get ns ${namespace} || kubectl create ns ${namespace}")
           //Update the imagetag to the latest version
                   sh("sed -i.bak 's#gcr.io/${project}/${appName}:${imageVersion}#${imageTag}#' ./k8s/production/*.yaml")
           //Create or update resources
                   sh("kubectl --namespace=${namespace} apply -f k8s/production/deployment.yaml")
                   sh("kubectl --namespace=${namespace} apply -f k8s/production/service.yaml")
           //Grab the external Ip address of the service
                   sh("echo http://`kubectl --namespace=${namespace} get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
                   break

              default:
                   sh("kubectl get ns ${namespace} || kubectl create ns ${namespace}")
                   sh("sed -i.bak 's#gcr.io/${project}/${appName}:${imageVersion}#${imageTag}#' ./k8s/development/*.yaml")
                   sh("kubectl --namespace=${namespace} apply -f k8s/development/deployment.yaml")
                   sh("kubectl --namespace=${namespace} apply -f k8s/development/deploymentService.yaml")
                   sh("echo http://`kubectl --namespace=${namespace} get service/${feSvcName} --output=json | jq -r '.status.loadBalancer.ingress[0].ip'` > ${feSvcName}")
                   break
  }

}
