alias du='du -kh'
alias cat='bat --style=numbers --theme=OneHalfDark'
alias df='df -kTh'
alias grep='grep --color=auto'
if ! type "eza" > /dev/null; then
	echo "eza not installed (install using cargo). resorting to plain ls"
	alias ls='ls -hF --color'
	alias ll='ls -al'
else
	alias ls='eza --icons=auto'
	alias ll='eza -al -snew --icons=auto'
fi
alias vi='nvim'
