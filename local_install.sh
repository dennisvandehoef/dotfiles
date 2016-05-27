sudo add-apt-repository ppa:webupd8team/atom

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
sudo apt-get install -y atom
sudo apt-get install -y fonts-opendyslexic

echo -e "\n\n\n\n\nInstalling Ruby\n\n\n\n\n"
\curl -sSL https://get.rvm.io | bash -s stable --rails
source ~/.rvm/scripts/rvm

echo -e "\n\n\n\n\nCleanup\n\n\n\n\n"
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean

rvm rvmrc warning ignore all.rvmrcs
rvm rvmrc warning ignore allGemfiles

echo -e "\n\n\n\n\nConfig Gem\n\n\n\n\n"
cp -r ~/.gemrc ~/.gemrc.old 2>/dev/null
rm -f ~/.gemrc 2>/dev/null
ln -s ~/dotfiles/gemrc ~/.gemrc

sudo gem install bundler
sudo gem install rails

echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir ~/dotfiles
mkdir ~/code
git clone https://github.com/dennisvandehoef/dotfiles.git ~/dotfiles

echo -e "\n\n\n\n\nConfig VIM\n\n\n\n\n"
cp -r ~/.vim ~/.vim.old 2>/dev/null
cp -r /usr/local/bin/vim /usr/local/bin/vim.old 2>/dev/null
cp -r ~/.vimrc ~/.vimrc.old 2>/dev/null

rm -fr ~/.vim 2>/dev/null
rm -f /usr/local/bin/vim  2>/dev/null
rm -f ~/.vimrc 2>/dev/null

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim /usr/local/bin/vim
ln -s ~/dotfiles/vimrc ~/.vimrc

echo -e "\n\n\n\n\nConfig GIT\n\n\n\n\n"
cp -r ~/.gitconfig ~/.gitconfig.old 2>/dev/null
cp -r ~/.gitignore_global ~/.gitignore_global.old 2>/dev/null

rm -f ~/.gitconfig 2>/dev/null
rm -f ~/.gitignore_global 2>/dev/null

ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

echo -e "\n\n\n\n\nConfig terminal\n\n\n\n\n"
cp -r ~/.bash_aliases ~/.bash_aliases.old 2>/dev/null
rm -f ~/.bash_aliases 2>/dev/null
ln -s ~/dotfiles/aliases ~/.bash_aliases

cp -r ~/.bashrc ~/.bashrc.old 2>/dev/null
rm -f ~/.bashrc 2>/dev/null
ln -s ~/dotfiles/bashrc ~/.bashrc

cp -r ~/.inputrc ~/.inputrc.old 2>/dev/null
rm -f ~/.inputrc 2>/dev/null
ln -s ~/dotfiles/inputrc ~/.inputrc

echo -e "\n\n\n\n\nConfig ATOM\n\n\n\n\n"
mkdir ~/.atom

cp -r ~/.atom/config.cson ~/.atom/config.cson.old 2>/dev/null
rm -f ~/.atom/config.cson 2>/dev/null
ln -s ~/dotfiles/atom/config.cson ~/.atom/config.cson

cp -r ~/.atom/keymap.cson ~/.atom/keymap.cson.old 2>/dev/null
rm -f ~/.atom/keymap.cson 2>/dev/null
ln -s ~/dotfiles/atom/keymap.cson ~/.atom/keymap.cson

cp -r ~/.atom/snippets.cson ~/.atom/snippets.cson.old 2>/dev/null
rm -f ~/.atom/snippets.cson 2>/dev/null
ln -s ~/dotfiles/atom/snippets.cson ~/.atom/snippets.cson

cp -r ~/.atom/styles.less ~/.atom/styles.less.old 2>/dev/null
rm -f ~/.atom/styles.less 2>/dev/null
ln -s ~/dotfiles/atom/styles.less ~/.atom/styles.less

cp -r ~/.atom/packages ~/.atom/packages.old 2>/dev/null
rm -f ~/.atom/packages 2>/dev/null
ln -s ~/dotfiles/atom/packages ~/.atom/packages

cp -r ~/.atom/init.coffee ~/.atom/init.coffee.old 2>/dev/null
rm -f ~/.atom/init.coffee 2>/dev/null
ln -s ~/dotfiles/atom/init.coffee ~/.atom/init.coffee

#mac @ work
echo '[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"' >> ~/.bash_profile


echo -e "\n\n\n\n\nFirst step is done\n\n\n\n\n"
echo -e "TODO:\n\nCreate SSH key end add on github.com\nManual: https://help.github.com/articles/generating-ssh-keys/"
echo -e "\n\nthen run the command:"
echo -e "curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/local_install_part_2.sh -o - | sh"
