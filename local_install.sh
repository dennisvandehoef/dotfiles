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

if [[ $(uname -s) == "Darwin" ]]; then
  source ~/code/private/dotfiles/setup_imac
fi

export bin_path=/usr/local/bin

# asdf
echo -e "\n\n\n\n\nasdf\n\n\n\n\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

cp -r ~/.asdfrc ~/.asdfrc.old >>/dev/null
rm -f ~/.asdfrc >>/dev/null
ln -s ~/code/private/dotfiles/asdfrc ~/.asdfrc

cp -r ~/.tool-versions ~/.tool-versions.old >>/dev/null
rm -f ~/.tool-versions >>/dev/null
ln -s ~/code/private/dotfiles/tool-versions ~/.tool-versions

cp -r ~/.default-gems ~/.default-gems.old >>/dev/null
rm -f ~/.default-gems >>/dev/null
ln -s ~/code/private/dotfiles/default-gems ~/.default-gems

asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add postgres https://github.com/smashedtoatoms/asdf-postgres.git
asdf plugin add redis https://github.com/smashedtoatoms/asdf-redis.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add yarn https://github.com/twuni/asdf-yarn.git

asdf install

# direnv
echo -e "\n\n\n\n\ninstalling tools\n\n\n\n\n"
curl -sfL https://direnv.net/install.sh | bash

mkdir -p ~/.config/direnv
cp -r ~/.config/direnv/direnv.toml ~/.config/direnv/direnv.toml.old >>/dev/null
rm -f ~/.config/direnv/direnv.toml >>/dev/null
ln -s ~/code/private/dotfiles/direnv.toml ~/.config/direnv/direnv.toml

# sqlc
go install github.com/kyleconroy/sqlc/cmd/sqlc@latest
