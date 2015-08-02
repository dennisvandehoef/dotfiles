rvm rvmrc warning ignore all.rvmrcs
rvm rvmrc warning ignore allGemfiles

echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir ~/dotfiles
mkdir ~/code
git clone git@github.com:dennisvandehoef/dotfiles.git ~/dotfiles

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

cp -r ~/.inputrc ~/.inputrc 2>/dev/null
rm -f ~/.inputrc 2>/dev/null
ln -s ~/dotfiles/inputrc ~/.inputrc

#mac @ work
echo '[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"' >> ~/.bash_profile

echo -e "\n\n\n\n\nConfig Gem\n\n\n\n\n"
cp -r ~/.gemrc ~/.gemrc.old 2>/dev/null
rm -f ~/.gemrc 2>/dev/null
ln -s ~/dotfiles/gemrc ~/.gemrc
