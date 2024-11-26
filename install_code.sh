export bin_path=/usr/local/bin

# asdf
echo -e "\n\n\n\n\nasdf\n\n\n\n\n"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

. "$HOME/.asdf/asdf.sh"

export GOPATH=$HOME/go
export GOPROXY=direct
export CGO_ENABLED=0
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

cp -r ~/.asdfrc ~/.asdfrc.old >>/dev/null
rm -f ~/.asdfrc >>/dev/null
ln -s ~/code/private/dotfiles/asdfrc ~/.asdfrc

cp -r ~/.tool-versions ~/.tool-versions.old >>/dev/null
rm -f ~/.tool-versions >>/dev/null
ln -s ~/code/private/dotfiles/tool-versions ~/.tool-versions

cp -r ~/.default-gems ~/.default-gems.old >>/dev/null
rm -f ~/.default-gems >>/dev/null
ln -s ~/code/private/dotfiles/default-gems ~/.default-gems

cp -r ~/.default-golang-pkgs ~/.default-golang-pkgs.old >>/dev/null
rm -f ~/.default-golang-pkgs >>/dev/null
ln -s ~/code/private/dotfiles/default-golang-pkgs ~/.default-golang-pkgs

asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin add terraform https://github.com/Banno/asdf-hashicorp.git
asdf plugin add terragrunt https://github.com/ohmer/asdf-terragrunt.git
asdf plugin add yarn https://github.com/twuni/asdf-yarn.git

asdf install

# direnv
echo -e "\n\n\n\n\ninstalling tools\n\n\n\n\n"
curl -sfL https://direnv.net/install.sh | bash

mkdir -p ~/.config/direnv
cp -r ~/.config/direnv/direnv.toml ~/.config/direnv/direnv.toml.old >>/dev/null
rm -f ~/.config/direnv/direnv.toml >>/dev/null
ln -s ~/code/private/dotfiles/direnv.toml ~/.config/direnv/direnv.toml

# yarn

mkdir -p ~/.config/yarn/global
cp -r ~/.config/yarn/global/package.json ~/.config/yarn/global/package.json.old >>/dev/null
rm -f ~/.config/yarn/global/package.json >>/dev/null
ln -s ~/code/private/dotfiles/package.json ~/.config/yarn/global/package.json

yarn install --cwd ~/.config/yarn/global
