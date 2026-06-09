alias cs='cd ~/node/sub'
alias ca='cd ~/node/aliveline'
alias cap='cd ~/node/autopack'
alias ct='cd ~/python/tasks'
alias cw='cd ~/python/word'

alias gs='gen-subs'
alias ss='setup-subs'
alias ws='watchpick --has-baseline --max-cps 15 --min-cps 5'

alias gn='gen-news'
alias rn='rename-news'
alias sn='setup-news'
alias wn='watchpick --type news'

alias gp='gen-posts'

alias cr='codex resume'
alias nd='npm run dev'
alias rs='repo-sync --sync'

alias v='view-task'
alias vc='view-task --file tasks_coworkers.json'

reloadsh() {
  if [ -n "${ZSH_VERSION-}" ]; then
    source ~/.zshrc
  elif [ -n "${BASH_VERSION-}" ]; then
    source ~/.bashrc
  else
    echo "Unsupported shell: $SHELL" >&2
    return 1
  fi
}
