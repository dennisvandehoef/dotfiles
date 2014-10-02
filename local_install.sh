echo -e "\n\n\n\n\nUpdating the system\n\n\n\n\n"
update

echo -e "\n\n\n\n\nprepare for MongoDB\n\n\n\n\n"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

echo -e "\n\n\n\n\nUpdate apt-get\n\n\n\n\n"
sudo apt-get update

echo -e "\n\n\n\n\nInstalling software\n\n\n\n\n"
sudo apt-get install mysql-server
sudo apt-get install -y mongodb-org
sudo apt-get install git
sudo apt-get install tree
sudo apt-get install unrar

echo -e "\n\n\n\n\nInstalling Ruby\n\n\n\n\n"
sudo apt-get install ruby-rvm
rvm install ruby --latest
sudo gem update --system
sudo gem install rails

echo -e "\n\n\n\n\nCleanup\n\n\n\n\n"
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean

echo -e "\n\n\n\n\nFirst step is done\n\n\n\n\n"
echo -e "next:\n 1)Create SSH key end add on github.com"
