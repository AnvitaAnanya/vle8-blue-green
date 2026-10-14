pipeline {
    agent any

    environment {
        KUBECONFIG = '/var/lib/jenkins/.kube/config'
    }

    options {
        timestamps()
    }

    stages {
        stage('Build Green Image') {
            steps {
                sh 'docker build -t myapp:v2 .'
            }
        }

        stage('Load Green Image') {
            steps {
                sh 'sudo -n /usr/local/bin/vle8-load-image'
            }
        }

        stage('Deploy Green') {
            steps {
                sh 'kubectl apply -f deployment-green.yaml'
                sh 'kubectl rollout status deployment/myapp-green --timeout=120s'
            }
        }

        stage('Verify Green') {
            steps {
                sh 'kubectl get pods -l app=myapp,color=green'
                sh 'kubectl get deployment myapp-green'
            }
        }

        stage('Approve Traffic Switch') {
            steps {
                input message: 'Green is ready. Switch live traffic to Green?', ok: 'Switch to Green'
            }
        }

        stage('Switch Traffic to Green') {
            steps {
                sh """kubectl patch service myapp-service -p '{"spec":{"selector":{"app":"myapp","color":"green"}}}'"""
                sh 'kubectl get service myapp-service -o wide'
            }
        }
    }
}
