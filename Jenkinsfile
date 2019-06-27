pipeline {
  options {
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  post { always { deleteDir() } }
  agent any
  environment {
    REGISTRY_HOST = "registry-jj.demo-rademade.com"
    PORTAINER_HOST = "portainer.demo-rademade.com"
    PROJECT_NAME = "sales-scoreboard"
  }
  stages {
    stage('Build') {
      steps {
        build job: 'CreateImages',  parameters: [
          string(name: 'SOURCE_DIRECTORY', value: "${WORKSPACE}"),
          string(name: 'REGISTRY_HOST', value: "${REGISTRY_HOST}"),
          string(name: 'PORTAINER_HOST', value: "${PORTAINER_HOST}"),
          string(name: 'BRANCH', value: "${BRANCH_NAME}"),
          string(name: 'PROJECT_NAME', value: "${PROJECT_NAME}")
        ]
      }
    }
    stage('Deploy') {
      steps {
        withCredentials([usernameColonPassword(credentialsId: 'portainer', variable: 'PORTAINER_CREDS')]) {
          build job: 'DeployImages',  parameters: [
            string(name: 'SOURCE_DIRECTORY', value: "${WORKSPACE}"),
            string(name: 'REGISTRY_HOST', value: "${REGISTRY_HOST}"),
            string(name: 'PORTAINER_HOST', value: "${PORTAINER_HOST}"),
            string(name: 'BRANCH', value: "${BRANCH_NAME}"),
            string(name: 'PROJECT_NAME', value: "${PROJECT_NAME}"),
            string(name: 'COMPOSE_YML', value: "docker-cloud.yml"),
            string(name: 'PORTAINER_CREDS', value: "${PORTAINER_CREDS}")
          ]
        }
      }
    }
  }
}
