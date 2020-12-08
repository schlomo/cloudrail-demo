pipeline {
    agent none

    stages {
        stage('TF init and apply') {
            agent {
                docker {
                    image 'hashicorp/terraform:0.13.5'
                    args '-it --entrypoint=/bin/bash' // See https://stackoverflow.com/questions/52558150/jenkins-pipeline-docker-container-is-not-running
                }
            }
            environment {
                AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
                AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
                AWS_REGION = credentials('AWS_REGION')
            }
            steps {
                sh '''
                        terraform init
                        terraform plan -out=plan.out
                 '''

            }
        }
        stage('Cloudrail') {
            agent {
                docker {
                    image 'indeni/cloudrail-cli:latest'
                    args '-it --entrypoint=/bin/bash' // See https://stackoverflow.com/questions/52558150/jenkins-pipeline-docker-container-is-not-running
                }
            }
            environment {
                CLOUDRAIL_API_KEY = credentials('CLOUDRAIL_API_KEY')
            }
            steps {
                sh '''
                    cloudrail run --directory "." --tf-plan "plan.out" \
                      --origin ci --build-link "${env.BUILD_URL}"  --execution-source-identifier "${env.BUILD_NUMBER}"  \
                      --api-key "$CLOUDRAIL_API_KEY" --cloud-account-id "$CLOUD_ACCOUNT_ID"

             '''
            }
        }
    }
}
