tap homebrew/dupes
tap homebrew/php

update
upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
install coreutils
# Install some other useful utilities like `sponge`
install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
install findutils
# Install GNU `sed`, overwriting the built-in `sed`
install gnu-sed --default-names
# Install Bash 4
install bash

install vim --with-override-system-vi
install macvim --with-override-system-vim --with-cscope --with-lua
install homebrew/dupes/grep

install mariadb
install unrar
install --without-apache --with-fpm --with-mysql php55

install rename
install automake
install autoconf
# latest 6.x.x version, since the rmgaic gem does not support 7.x.x now
install https://raw.githubusercontent.com/Homebrew/homebrew-core/6f014f2b7f1f9e618fd5c0ae9c93befea671f8be/Formula/imagemagick.rb
install jpegoptim
install optipng
install pngquant
install curl
install watch
install ack
install sqlite
install readline
install redis
install mongodb
install node
install pv
install rename
install tree
install --with-http2  nginx
install dnsmasq
install tmux
install lftp
install htop
install chromedriver
install phantomjs
install wget

#GO
install go --with-cc-all
install hg
install Bazaar
install fswatch
install gawk
install gnu-tar


install caskroom/cask/brew-cask
cask install google-chrome
cask install firefox
cask install rowanj-gitx
cask install hipchat
cask install virtualbox
cask install sequel-pro
cask install iterm2
cask install filezilla
cask install java
cask install openoffice
cask install rdm
cask install robomongo
cask install launchrocket

link
cleanup
