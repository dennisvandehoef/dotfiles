echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir -p ~/code/arh
mkdir -p ~/code/private/dotfiles
git clone https://github.com/dennisvandehoef/dotfiles.git ~/code/private/dotfiles

echo -e "\n\n\n\n\nConfig VIM\n\n\n\n\n"
cp -r ~/.vim ~/.vim.old >>/dev/null
cp -r /usr/local/bin/vim /usr/local/bin/vim.old >>/dev/null
cp -r ~/.vimrc ~/.vimrc.old >>/dev/null

rm -fr ~/.vim >>/dev/null
rm -f /usr/local/bin/vim  >>/dev/null
rm -f ~/.vimrc >>/dev/null

ln -s ~/code/private/dotfiles/vim ~/.vim
ln -s ~/code/private/dotfiles/vim /usr/local/bin/vim
ln -s ~/code/private/dotfiles/vim/vimrc ~/.vimrc

echo -e "\n\n\n\n\nConfig GIT\n\n\n\n\n"
cp -r ~/.gitconfig ~/.gitconfig.old >>/dev/null
cp -r ~/.gitignore_global ~/.gitignore_global.old >>/dev/null

rm -f ~/.gitconfig >>/dev/null
rm -f ~/.gitignore_global >>/dev/null

ln -s ~/code/private/dotfiles/gitconfig ~/.gitconfig
ln -s ~/code/private/dotfiles/gitignore_global ~/.gitignore_global

echo -e "\n\n\n\n\nzsh\n\n\n\n\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

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

cp -r ~/.zshrc ~/.zshrc.old >>/dev/null
rm -f ~/.zshrc >>/dev/null
ln -s ~/code/private/dotfiles/zshrc ~/.zshrc
