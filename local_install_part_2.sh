echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir ~/dotfiles
git clone git@github.com:dennisvandehoef/dotfiles.git ~/dotfiles

echo -e "\n\n\n\n\nConfig VIM\n\n\n\n\n"
cp -r ~/.vim ~/.vim.old 2>/dev/null
cp -r ~/.vimrc ~/.vimrc.old 2>/dev/null
rm -fr ~/.vim 2>/dev/null
rm -f ~/.vimrc 2>/dev/null

ln -s ~/dotfiles/.vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc


echo -e "\n\n\n\n\nConfig GIT\n\n\n\n\n"
cp -r ~/.gitconfig ~/.vigitconfigm.old 2>/dev/null
rm -f ~/.gitconfig 2>/dev/null
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
