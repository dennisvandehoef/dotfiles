alias ..="cd .."

alias ls='ls -alhG'
alias dotfiles="cd ~/code/private/dotfiles"

# GIT
alias g="git"
alias gpl="git pl"
alias gps="git push"
alias gst="git st"

# Docker
alias docker-compose="docker compose"
alias dclean="docker container prune -f && docker image prune -af --filter until=168h && docker volume prune -af"

# AWS & EKS
source ~/code/private/dotfiles/aws-switch-to.sh
alias staging="aws_switch_to staging"
alias production="aws_switch_to production"
alias services="aws_switch_to services"
alias kaeuferportal="aws_switch_to kp"
alias development="aws_switch_to dev"
alias data="aws_switch_to data"

# alias babysit="agent -p --force --trust --output-format json 'Babysit the MR of this branch. Work on it: (1) read the comments, and reply to them in the related thread (2) Rebase: run \"git fetch origin && git rebase origin/staging\". IMPORTANT rebase rules — only the MR'\''s own commits may be rewritten; Never use git merge. Never rewrite commits that already exist on origin/staging. After rebasing, \"git push origin BRANCH_NAME --force-with-lease\". (2) Inspect CI failures from the pipeline URL above and fix them (generators / linting / tests — whatever is failing). (4) Push fixes and watch the new pipeline until green or blocked. IMPORTANT commit hygiene — you may make intermediate/debug commits while working, but before finishing you MUST clean them up: use \"git rebase -i origin/staging\" to squash or drop any temporary commits so the final branch contains only the original commits plus your commits that fix real problems. No WIP, fix, debug, or throwaway commits may remain. Force-push the cleaned history with \"git push origin BRANCH_NAME --force-with-lease\" before declaring done.'"
alias babysit="agent -p --force --trust --output-format text 'execute prompt in ~/code/private/dotfiles/prompts/babysit.md'"

update_ruby(){
  local version=$1

  echo $version >.ruby-version
  sed -i -E "s/FROM ruby:[a-z0-9.-]{2,}/FROM ruby:$version/" Dockerfile
  sed -i -E "s/ruby [a-z0-9.-]{2,}/ruby $version/" Gemfile.lock
  docker-compose build
}

function cursor {
  open -a "/Applications/Cursor.app" "$@"
}
