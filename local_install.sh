echo -e "\n\n\n\n\nUpdate apt-get\n\n\n\n\n"
sudo apt-get update

echo -e "\n\n\n\n\nInstalling software\n\n\n\n\n"
sudo apt-get install -y mysql-server
sudo apt-get install -y git
sudo apt-get install -y tree
sudo apt-get install -y bundler
sudo apt-get install -y unrar
sudo apt-get install -y vim-gnome
sudo apt-get install -y nodejs
sudo apt-get install -y libmysqlclient-dev

echo -e "\n\n\n\n\nInstalling Ruby\n\n\n\n\n"
\curl -sSL https://get.rvm.io | bash -s stable --rails
source ~/.rvm/scripts/rvm

echo -e "\n\n\n\n\nCleanup\n\n\n\n\n"
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean

echo -e "\n\n\n\n\nFirst step is done\n\n\n\n\n"
echo -e "TODO:\n\nCreate SSH key end add on github.com\nManual: https://help.github.com/articles/generating-ssh-keys/"
echo -e "\n\nthen run the command:"
echo -e "curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/local_install_part_2.sh -o - | sh"
