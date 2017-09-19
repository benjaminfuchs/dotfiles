# General
alias ls='ls --color'
LS_COLORS='di=1:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rpm=90'
export LS_COLORS
alias ll='ls -la'
sdifffunction() {
    meld <( echo $1 ) <( echo $2 )
}
alias sdiff=sdifffunction
alias grep='grep --color'
makefunction() {
    make $1 2>&1 | grep --color -iP "\^|warning:|error:|"
}
alias make=makefunction
