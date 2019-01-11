#!/usr/bin/groovy
/**
        * Builds RPM package using Effin Package Manager
 */


pipeline {
    agent { label 'fpm' }
    options {
	buildDiscarder(logRotator(numToKeepStr:'10'))
        disableConcurrentBuilds()
        timeout(time: 10, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Version') {
            steps {
                script {
                //get the short SHA of git commit, must have git command available
                def gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
                def shortCommit = gitCommit.take(6)
                def version = readFile('packages/lab-certs/version.txt')
		println "Short Git Commit ID: ${shortCommit}"
		println "Current Version: ${version}"
                //set version in display name
                currentBuild.displayName = "${version}-${env.BUILD_NUMBER}"
                //currentBuild.description = "git commit ${gitCommit}"
                }
             }
        }
        stage('Build Package') {
            steps {
                    parallel (
                        "RPM":{
                            sh "/usr/local/bin/fpm -s dir -t rpm -a noarch -n studio1-lab-cert -v 1.0.3 --iteration ${env.BUILD_NUMBER} --rpm-summary \"Installs *.lab.lab wildcard certificates\" --rpm-attr 400,apache,apache:/opt/ssl/lab.lab.key --rpm-attr 400,apache,apache:/opt/ssl/lab.lab.crt --rpm-attr 400,apache,apache:/opt/ssl/intermediate.crt ./cert/lab.lab/=/opt/ssl/"
                         },
                         "DEB":{
                            println "Not yet implemented"
                         }
                    )
            }
        }
        stage('Test RPM') {
            steps {
                    sh "rpm -ivh --test studio1-lab-cert-*.rpm"
            }
        }
        stage('Archive RPM') {
            steps {
                    archiveArtifacts artifacts: '*.rpm', excludes: null, fingerprint: true
            }
        }
    }

    post {
        always {
            deleteDir()
        }
    }
}
