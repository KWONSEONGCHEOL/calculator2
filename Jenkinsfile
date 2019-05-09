pipeline {
        triggers{
        pollSCM('*/5 * * * *')
    }
    agent any
    stages {
        stage ('checkout') {
            steps {
                git url :'https://github.com/KWONSEONGCHEOL/calculator2.git'
            }
        }
      stage('Compile'){
            steps {
                sh './gradlew compileJava'
            }
        }
        stage ('Unit test') {
            steps {
                sh './gradlew test'
            }
        }
        stage ("code coverage") {
            steps {
                sh "./gradlew jacocoTestReport"
                sh "./gradlew jacocoTestCoverageVerification"
                
            }
        }
        stage ("Static code analysis") {
            steps {
                sh "./gradlew checkstyleMain"
                publishHTML (target: [
                    reportDir: 'build/reports/checkstyle/',
                    reportFiles: 'main.html',
                    reportName: "checkstyle Report"])
            }
        }
        stage("Package"){
            steps {
                sh "./gradlew build"
            }
        }
        
        stage("Docker build"){
            steps {
                sh "docker build -t localhost:5000/kwonseongcheol/calculator ."
            }
        }
       stage("Docker push"){
            steps {
                sh "docker push localhost:5000/kwonseongcheol/calculator"
            }
        }
        stage("Deploy to staging") {
            steps {
               /* sh "docker run -d --rm -p 8090:8090 \
                --name calculator localhost:5000/kwonseongcheol/calculator"*/
                 sh "docker-compose up -d"
            }
        }
       stage("Acceptance test") {
            steps {
                sleep 20
                sh "./acceptance_test.sh"
                
            }
        }

        
    }
    post {
        always {
          /*  mail to : "zx7613@naver.com",
            subject : "Completed Pipeline : ${currentBuild.fullDisplayName}",
            body: "Your build completed, please check: ${env.BUILD_URL}"*/
        //    sh "docker stop calculator"
            sh "docker-compose down"
        }
    }
}
