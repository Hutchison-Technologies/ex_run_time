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
      volumeMounts:
        - mountPath: /cache
          name: cachepd
  volumes:
    - name: cachepd
      persistentVolumeClaim:
        claimName: ${appName}-cache
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${appName}-cache
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
"""
    }
  }
  stages {
    stage('Run Unit Tests') {
      steps {
        container('testbox') {
          sh "mix local.hex --force"
          sh "mix local.rebar --force"
          sh "[ -d \"/cache/_build\" ] && cp -Rf /cache/_build ."
          sh "[ -d \"/cache/deps\" ] && cp -Rf /cache/deps ."
          sh "mix deps.get"
          sh "mix dialyzer"
          sh "mix test --cover"
          sh "cp -Rf _build /cache/_build"
          sh "cp -Rf deps /cache/deps"
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