### Advanced Installations

### Maven Installation and Setup

For some of the workshops, we would need to compile java packages, and hence we need to install maven in the image. 

* Download and untar 

		cd opt
		sudo wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz --no-check-certificate
		sudo tar -xvxf apache-maven-3.6.0-bin.tar.gz

* Update in /etc/environment file

		M2_HOME-"/opt/apache-maven-3.6.0"
		PATH=$M2_HOME:$PATH

* Setup this in the command window for the current session

		export M2_HOME=/opt/apache-maven-3.6.0
		export PATH=$M2_HOME/bin:$PATH

* Configure alternatives to invoke maven

		sudo update-alternatives --install "/usr/bin/mvn" "mvn" "/opt/apache-maven-3.6.0/bin/mvn" 0
		sudo update-alternatives --set mvn /opt/apache-maven-3.6.0/bin/mvn
	
* Configure autocomplete for complex maven commands

		sudo wget https://raw.github.com/dimaj/maven-bash-completion/master/bash_completion.bash --output-document /etc/bash_completion.d/mvn --no-check-certificate

* Check that Maven is installed

		mvn --version
