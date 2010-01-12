
# some more ls aliases
alias la='ls -lA'
alias lsd='ls -d */'

# git aliases
alias gist='git status'
alias giad='git add'

# for rotating scratch dir
alias t='cd `t.sh`'

# save/restore mtimes
alias mtimesave='find . -type f -printf "touch -t %TY%Tm%Td%TH%TM \"%P\"\n"'
