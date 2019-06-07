def appName = "ex-run-time"

pipeline {
  agent {
    kubernetes {
      label "${appName}-tests"
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  restartPolicy: Never
  containers:
    - name: testbox
      image: elixir:1.7.4-alpine
      command:
        - cat
      tty: true
"""
    }
  }
  stages {
    stage('Run Unit Tests') {
      steps {
        container('testbox') {
          sh "mix local.hex --force"
          sh "mix local.rebar --force"
          sh "md5sum mix.lock"
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