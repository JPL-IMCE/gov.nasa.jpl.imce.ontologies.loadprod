pipeline {
	agent {
		label 'IMCE'
	}
	stages {
	stage('Clone Repository') {
		steps {
			checkout scm
		}
	}	

	stage('Checkout Ontologies') {
		steps {
			dir('gov.nasa.jpl.imce.ontologies.public') {
        		git url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.public.git'
    		}	
			checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'ontologies']], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.fuseki']]])
	 	}
	}

	stage('Build Loaded Production Image') {
		steps {
			timeout(time: 30, unit: 'MINUTES') {
				sh returnStdout: true, script: 'sudo docker build -t jplimce/gov.nasa.jpl.imce.ontologies.loadprod .'
            }
		}
	}

	stage('Push Image') {
		steps {
			echo 'Pushing!'
		}
	}
	}
}