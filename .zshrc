if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Clone antidote if necessary.
[[ -d $HOME/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${HOME}/.antidote

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.


##################
#    EXPORTS    ##
##################
export PATH="$HOME/bin:$PYENV_ROOT/bin:$PATH"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245,underline,bold"
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOQUIT=false
export ZSHZ_TILDE=1
export LS_COLORS="$(vivid generate one-dark)"

export HOME_CONF="$HOME/.config"

. ${HOME_CONF}/functions.sh
. ${HOME_CONF}/aliases.sh

##################
#  Key Bindings ##
##################
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line


##################
#  Zsh options  ##
##################
setopt complete_in_word
setopt magic_equal_subst
zmodload zsh/terminfo

#make zsh not expand wildcards in ssh, scp, rsync commands:
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
expand_wildcard_commands=(scp ssh rsync)
zstyle -e :urlglobber url-other-schema \
'[[ (($expand_wildcard_commands[(I)$words[1]])) ]] && reply=("*") || reply=(http https ftp rsync)'

##################
#   Functions   ##
##################
# Autoload functions you might want to use with antidote.
# ZFUNCDIR=$HOME/functions/
# fpath=($ZFUNCDIR $fpath)
# autoload -Uz $fpath[1]/*(.:t)

##################
#    ZSTYLES    ##
##################
[[ -e $HOME/.zstyles ]] && source $HOME/.zstyles

# Create an amazing Zsh config using antidote plugins.
source $HOME/.antidote/antidote.zsh
antidote load

# autoload -Uz compinit && compinit
##################
#      FZF      ##
##################
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--tiebreak=end'
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:${fg},bg:${bg},hl:${orange} \
--color=fg+:${fg},bg+:${bg_highlight},hl+:${orange} \
--color=info:${blue},prompt:${cyan},pointer:${cyan} \
--color=marker:${green},spinner:${green},header:${green}"
if type fd &> /dev/null; then
	export FZF_DEFAULT_COMMAND="fd --type file --color=always"
	export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --ansi"
elif type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg -p ~/.gitignore -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"


##################
#     PYENV     ##
##################
export PYTHON_CONFIGURE_OPTS="--enable-shared --enable-loadable-sqlite-extensions"
export PYENV_ROOT="$HOME/.pyenv"
if [ -d ${PYENV_ROOT} ] ; then
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
fi


##################
#      P10K     ##
##################
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

unset ZSH_AUTOSUGGEST_USE_ASYNC

autoload -Uz compinit && compinit

