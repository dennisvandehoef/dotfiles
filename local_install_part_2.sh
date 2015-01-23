rvm rvmrc warning ignore all.rvmrcs
rvm rvmrc warning ignore allGemfiles

echo -e "\n\n\n\n\nCreating git reposetory\n\n\n\n\n"
mkdir ~/dotfiles
mkdir ~/code
git clone git@github.com:dennisvandehoef/dotfiles.git ~/dotfiles

echo -e "\n\n\n\n\nConfig VIM\n\n\n\n\n"
cp -r ~/.vim ~/.vim.old 2>/dev/null
cp -r ~/.vimrc ~/.vimrc.old 2>/dev/null

rm -fr ~/.vim 2>/dev/null
rm -f ~/.vimrc 2>/dev/null

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vimrc ~/.vimrc


echo -e "\n\n\n\n\nConfig GIT\n\n\n\n\n"
cp -r ~/.gitconfig ~/.gitconfig.old 2>/dev/null
cp -r ~/.gitignore_global ~/.gitignore_global.old 2>/dev/null

rm -f ~/.gitconfig 2>/dev/null
rm -f ~/.gitignore_global 2>/dev/null

ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/gitignore_global ~/.gitignore_global

echo -e "\n\n\n\n\nConfig aliases\n\n\n\n\n"
cp -r ~/.bash_aliases ~/.bash_aliases.old 2>/dev/null

rm -f ~/.bash_aliases 2>/dev/null

ln -s ~/dotfiles/aliases ~/.bash_aliases
