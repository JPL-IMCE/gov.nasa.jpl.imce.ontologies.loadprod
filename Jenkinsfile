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

	stage('Get Ontologies') {
		steps {
			dir('gov.nasa.jpl.imce.ontologies.public') {
        		git url: 'https://github.com/JPL-IMCE/gov.nasa.jpl.imce.ontologies.public.git'
    		}	
	 	}
	}

	stage('Build Loaded Production Image') {
		steps {
		sh returnStdout: true, script: 'sudo docker build -t jplimce/gov.nasa.jpl.imce.ontologies.loadprod .'
		}
	}

	stage('Push Image') {
		steps {
			echo 'Pushing!'
		}
	}
	}
}