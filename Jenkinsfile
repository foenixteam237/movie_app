pipeline {
    agent any
    stages {
        stage('git repo & clean') {
            steps {
                sh "rm  -r TicketBookingServiceJunitTesting"
                sh "git clone https://github.com/foenixteam237/movie_app.git"
            }
        }
       
        stage('run') {
            steps {
                sh "flutter run"
            }
        }
        
    }
}
