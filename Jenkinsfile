pipeline{
    agent any
    tools{
        maven 'maven'
    }
    
    stages{
        stage('checkout'){
            steps{
                git branch: 'main',url: 'https://github.com/Coding4Deep/java-k8s-project.git'
            }
        }
        stage('Build'){
            steps{
                sh ' mvn clean package'
            }
        }
        stage('DockerBuild'){
            steps{
                sh ' docker build -t deepaksag/java-k8s-app . '
            }
        }
       stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "Dockerhub", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push deepaksag/java-k8s-app
                        docker logout
                    """
                }
            }
        }
        
        
        
        
        
        
    }
}
