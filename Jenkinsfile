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
          name: cachepvc
      env:
        - name: HEX_API_KEY
          valueFrom:
            secretKeyRef:
              name: hex-key
              key: key
  volumes:
    - name: cachepvc
      persistentVolumeClaim:
        claimName: ex-run-time-build-cache
"""
    }
  }
  stages {
    stage('Run Unit Tests') {
      steps {
        container('testbox') {
          sh "mix local.hex --force"
          sh "mix local.rebar --force"
          sh "if [ -d \"/cache/_build\" ]; then cp -Rf /cache/_build .; fi"
          sh "if [ -d \"/cache/deps\" ]; then cp -Rf /cache/deps .; fi"
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
    stage('Publish to Hex') {
      when {
        buildingTag()
      }
      steps {
        container('testbox') {
          sh "mix docs"
          sh "mix hex.publish --yes"
        }
      }
    }
  }
}