pipeline {
    agent any
    stages {
        stage('git repo & clean') {
            steps {
                sh "git clone https://github.com/foenixteam237/movie_app.git"
            }
        }
       
        stage('run') {
            steps {
                //sh "flutter run"
                flutter doctor
            }
        }
        
    }
}
