pipeline {
  agent {
    kubernetes {
      label "ex-run-time-tests"
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  containers:
  - name: testbox
    image: elixir:1.7.4-alpine
    command:
      - cat
    tty: true
  restartPolicy: Never
"""
    }
  }
  stages {
    stage('Run Unit Tests') {
      steps {
        container('testbox') {
          sh "mix local.hex --force"
          sh "mix local.rebar --force"
          sh "mix deps.get"
          sh "mix dialyzer"
          sh "mix test --cover"
        }
      }
      post {
        always {
          junit 'junit.xml'
          cobertura coberturaReportFile: "coverage.xml"
        }
      }
    }
    /*
    run docs task, fail if the docs have changed
    if building tag:
    publish to hex
    */
  }
}