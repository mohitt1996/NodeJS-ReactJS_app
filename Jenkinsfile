pipeline{
    agent{label 'Worker_JS'}
    
    stages{
        stage('code'){
            steps{
                git url:'https://github.com/mohitt1996/two-tier-flask-app.git', branch:'master'
            }
        }
        stage('build & test'){
            steps{
                sh 'docker build . -t node:14'
            }
        }
        stage('image push to dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "Github", passwordVariable: "dockerHubPass", usernameVariable: "dockerhubUsr")]) {
                    sh "docker login -u ${dockerhubUsr} -p ${dockerHubPass}"
                    sh "docker tag node:14 ${dockerhubUsr}/node-14:latest"
                    sh "docker push ${dockerhubUsr}/node-14:latest"
                }
            }
        }
        stage('deploy'){
            steps{
                sh 'docker-compose down'
                sh "docker-compose up -d "
                
                
            }
        }
    }
}
