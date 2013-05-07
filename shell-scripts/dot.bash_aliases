# put in ~/.bashrc:
# if [ -f ~/.bash_aliases ]; then
#     . ~/.bash_aliases
# fi

psg(){ ps aux | grep -v grep | egrep -e "$1|USER"; }
nohist(){ export HISTFILE=/dev/null; }

alias shred="shred -fuvz"
alias serve.py="python -m SimpleHTTPServer"
alias pingo="ping www.google.com"

# for apt-based distros:
alias aps="aptitude search"
alias agi="sudo apt-get install"
alias agr="sudo apt-get remove --auto-remove"

alias tmux="tmux -2"
