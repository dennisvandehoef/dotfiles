read -p "Create SSH-key for e-mailadres: " sshMail
read -p "Enter passphrase (empty for no passphrase): " passFirst
read -p "Enter same passphrase again: " passAgain

ssh-keygen -t rsa -C $sshMail

$passFirst
$passAgain

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
