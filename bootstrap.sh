#!/usr/bin/env bash

# Add Oracle Java Repo
sudo add-apt-repository ppa:webupd8team/java  -y

# update apt
sudo apt-get update

# install java

#accept the licenses
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install oracle-java6-installer -y
sudo apt-get install oracle-java6-set-default -y

#setup glassfish
#Add a new user called glassfish
sudo adduser --home /home/glassfish --system --shell /bin/bash glassfish
 
#add a new group for glassfish administration
sudo groupadd glassfishadm
 
#add your users that shall be Glassfish adminstrators
#since this is a vagrant bootstrap lets just default to vagrant
sudo usermod -a -G glassfishadm vagrant 

GLASSFISH_HOME=/opt/glassfish3
JAVA_HOME=/usr/lib/jvm/java-6-oracle
echo "export GLASSFISH_HOME=$GLASSFISH_HOME" >> /etc/bash.bashrc 
echo "export JAVA_HOME=$JAVA_HOME" >> /etc/bash.bashrc 
echo "export AS_JAVA=$JAVA_HOME" >> /etc/bash.bashrc 
echo "export PATH=$PATH:$GLASSFISH_HOME/bin" >> /etc/bash.bashrc 

echo "JAVA_HOME=$JAVA_HOME" >> /etc/environment
echo "AS_JAVA=$JAVA_HOME" >> /etc/environment

#install glassfish dependencies
sudo apt-get install unzip -y

cd /tmp
wget http://download.java.net/glassfish/3.1.1/release/glassfish-3.1.1.zip
unzip glassfish-3.1.1.zip
rm glassfish-3.1.1.zip
sudo mv glassfish3 $GLASSFISH_HOME && sudo chown -R glassfish:glassfishadm $GLASSFISH_HOME
sudo chmod -R ug+rwx $GLASSFISH_HOME/bin/
sudo chmod -R ug+rwx $GLASSFISH_HOME/bin/
sudo chmod -R o-rwx $GLASSFISH_HOME/glassfish/bin/
sudo chmod -R o-rwx $GLASSFISH_HOME/glassfish/bin/

sudo cp /vagrant/glassfish.init.d /etc/init.d/glassfish
sudo chmod a+x /etc/init.d/glassfish
sudo update-rc.d glassfish defaults

# Start glassfish after provisioning
sudo service glassfish start
