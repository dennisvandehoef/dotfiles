echo -e "\n\n\n\n\nprepare for MongoDB\n\n\n\n\n"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

echo -e "\n\n\n\n\nUpdate apt-get\n\n\n\n\n"
sudo apt-get update

echo -e "\n\n\n\n\nInstalling software\n\n\n\n\n"
sudo apt-get install -y mysql-server
sudo apt-get install -y mongodb-org
sudo apt-get install -y git
sudo apt-get install -y tree
sudo apt-get install -y bundler
sudo apt-get install -y unrar
sudo apt-get install -y vim-gnome
sudo apt-get install -y nodejs

echo -e "\n\n\n\n\nInstalling Ruby\n\n\n\n\n"
\curl -sSL https://get.rvm.io | bash -s stable --rails
source ~/.rvm/scripts/rvm

sudo gem install rails




echo -e "\n\n\n\n\nCleanup\n\n\n\n\n"
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean

echo -e "\n\n\n\n\nFirst step is done\n\n\n\n\n"
echo -e "TODO:\n\nCreate SSH key end add on github.com\nManual: https://help.github.com/articles/generating-ssh-keys/"
echo -e "\n\nthen run the command:"
echo -e "curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/local_install_part_2.sh -o - | sh"
