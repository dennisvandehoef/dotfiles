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
ln -s  ~/code/private/dotfiles/xiotin.zsh-theme ~/.oh-my-zsh/custom/themes/xiotin.zsh-theme

cp -r ~/.zshrc ~/.zshrc.old >>/dev/null
rm -f ~/.zshrc >>/dev/null
ln -s ~/code/private/dotfiles/zshrc ~/.zshrc

export bin_path=/usr/local/bin

# asdf
echo -e "\n\n\n\n\nasdf\n\n\n\n\n"
# TODO ADD

# direnv
echo -e "\n\n\n\n\ndirenv\n\n\n\n\n"
curl -sfL https://direnv.net/install.sh | bash
