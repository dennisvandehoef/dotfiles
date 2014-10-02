update

#prepare MongoDB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

#basic prepare
sudo apt-get update

#installs
sudo apt-get install mysql-server
sudo apt-get install -y mongodb-org
sudo apt-get install git
sudo apt-get install tree
sudo apt-get install unrar

sudo apt-get install ruby-rvm
rvm install ruby --latest
sudo gem update --system
sudo gem install rails

#cleanup
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean
