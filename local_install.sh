echo -e "\n\n\n\n\nInstalling Ruby\n\n\n\n\n"


rvm rvmrc warning ignore all.rvmrcs
rvm rvmrc warning ignore allGemfiles

echo -e "\n\n\n\n\nConfig Gem\n\n\n\n\n"
cp -r ~/.gemrc ~/.gemrc.old >>/dev/null
rm -f ~/.gemrc >>/dev/null
ln -s ~/dotfiles/gemrc ~/.gemrc

cd .

gem install bundler
gem install rails

echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir ~/dotfiles
mkdir ~/code
git clone https://github.com/dennisvandehoef/dotfiles.git ~/dotfiles

echo -e "\n\n\n\n\nConfig VIM\n\n\n\n\n"
cp -r ~/.vim ~/.vim.old >>/dev/null
cp -r /usr/local/bin/vim /usr/local/bin/vim.old >>/dev/null
cp -r ~/.vimrc ~/.vimrc.old >>/dev/null

rm -fr ~/.vim >>/dev/null
rm -f /usr/local/bin/vim  >>/dev/null
rm -f ~/.vimrc >>/dev/null

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim /usr/local/bin/vim
ln -s ~/dotfiles/vimrc ~/.vimrc

echo -e "\n\n\n\n\nConfig GIT\n\n\n\n\n"
cp -r ~/.gitconfig ~/.gitconfig.old >>/dev/null
cp -r ~/.gitignore_global ~/.gitignore_global.old >>/dev/null

rm -f ~/.gitconfig >>/dev/null
rm -f ~/.gitignore_global >>/dev/null

ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

echo -e "\n\n\n\n\nConfig terminal\n\n\n\n\n"
cp -r ~/.bash_aliases ~/.bash_aliases.old >>/dev/null
rm -f ~/.bash_aliases >>/dev/null
ln -s ~/dotfiles/aliases ~/.bash_aliases

cp -r ~/.bashrc ~/.bashrc.old >>/dev/null
rm -f ~/.bashrc >>/dev/null
ln -s ~/dotfiles/bashrc ~/.bashrc

cp -r ~/.inputrc ~/.inputrc.old >>/dev/null
rm -f ~/.inputrc >>/dev/null
ln -s ~/dotfiles/inputrc ~/.inputrc

echo -e "\n\n\n\n\nConfig ATOM\n\n\n\n\n"
mkdir ~/.atom

cp -r ~/.atom/config.cson ~/.atom/config.cson.old >>/dev/null
rm -f ~/.atom/config.cson >>/dev/null
ln -s ~/dotfiles/atom/config.cson ~/.atom/config.cson

cp -r ~/.atom/keymap.cson ~/.atom/keymap.cson.old >>/dev/null
rm -f ~/.atom/keymap.cson >>/dev/null
ln -s ~/dotfiles/atom/keymap.cson ~/.atom/keymap.cson

cp -r ~/.atom/snippets.cson ~/.atom/snippets.cson.old >>/dev/null
rm -f ~/.atom/snippets.cson >>/dev/null
ln -s ~/dotfiles/atom/snippets.cson ~/.atom/snippets.cson

cp -r ~/.atom/styles.less ~/.atom/styles.less.old >>/dev/null
rm -f ~/.atom/styles.less >>/dev/null
ln -s ~/dotfiles/atom/styles.less ~/.atom/styles.less

cp -r ~/.atom/packages ~/.atom/packages.old >>/dev/null
rm -f ~/.atom/packages >>/dev/null
ln -s ~/dotfiles/atom/packages ~/.atom/packages

cp -r ~/.atom/init.coffee ~/.atom/init.coffee.old >>/dev/null
rm -f ~/.atom/init.coffee >>/dev/null
ln -s ~/dotfiles/atom/init.coffee ~/.atom/init.coffee

echo '[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"' >> ~/.bash_profile
