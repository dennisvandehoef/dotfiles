## Quick Install

first:
```
sudo apt-get install curl
curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/install_basic.sh -o - | sh
curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/install_code.sh -o - | sh
curl https://raw.githubusercontent.com/dennisvandehoef/dotfiles/master/install_mac.sh -o - | sh
```

after setting up ssh & computer, run the following:

```
dotfiles
git remote set-url --push origin git@github.com:dennisvandehoef/dotfiles.git
```
