
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function update_nvim()
{
        pushd ~/bin
        \wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
        \mv nvim.appimage nvim
        chmod a+rx nvim
        popd
}

export TERMINFO=${HOME}/.local/kitty.app/lib/kitty/terminfo

export HISTORY_SUBSTRING_SEARCH_FUZZY=true

source ~/antigen.zsh
antigen use oh-my-zsh

antigen bundle git
antigen bundle sudo
antigen bundle ubuntu
antigen bundle history
antigen bundle ssh
antigen bundle ssh-agent
antigen bundle tmux
antigen bundle pipenv
antigen bundle zsh-users/zsh-completions
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions

# antigen theme denysdovhan/spaceship-prompt

# these are last
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma-continuum/fast-syntax-highlighting

antigen bundle zsh-users/zsh-history-substring-search

antigen theme romkatv/powerlevel10k

antigen apply

# zstyle ':fzf-tab:complete:*' fzf-bindings 'tab:accept'

if [ ! -f ${HOME}/.antigen/bundles/Aloxaf/fzf-tab/modules/Src/aloxaf/fzftab.so ]; then
	build-fzf-tab-module
fi


DISABLE_AUTO_TITLE="true"
ZSH_TMUX_FIXTERM="false"
ZSH_TMUX_FIXTERM_WITH_256COLOR='tmux-256colors'

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "

# Customize to your needs...
#

zstyle :omz:plugins:ssh-agent agent-forwarding on

# ignore double slashes in file completion
zstyle :completion:\* squeeze-slashes true

# set autosuggest color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245,underline,bold"
export ZSH_AUTOSUGGEST_USE_ASYNC="True"
# use emacs keys
bindkey -e

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "[A" history-substring-search-up
bindkey "[B" history-substring-search-down

bindkey '^[[1;5C' emacs-forward-word
bindkey '^[[1;5D' emacs-backward-word

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# want share_history
setopt share_history

#complete in middle of word
setopt complete_in_word

#expand ~ after a '='
setopt magic_equal_subst

#specify which chars to skip over:
export WORDCHARS='*?_-.[]~/&;!#$%^(){}<>'

#make zsh not expand wildcards in ssh,scp commands:
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema \
'[[ $words[1] == scp ]] && reply=("*") || reply=(http https ftp rsync)'

############### HOME CONF ###############
HOME_CONF=${HOME}/.config
HOME_LIB=${HOME}/lib
HOME_BIN=${HOME}/bin
#########################################

export PATH=${HOME_BIN}:${PATH:=""}:/sbin:~/.local/kitty.app/bin/:${HOME}/.dotnet:${HOME}/.cargo/bin:${HOME}/bin
alias vi=nvim
EDITOR="nvim"
export EDITOR="nvim"
PAGER='less -r'

# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib:/usr/local/cuda/lib64/

#export HOSTNAME=$(hostname)
export EDITOR VISUAL HOME_CONF HOME_LIB
export HOME_BIN PAGER
#export LC_ALL=C
export LC_ALL=en_IL.UTF-8
#export PYTHONPATH=${PYTHONPATH}:${HOME}/python:~/work/vault/code/vault_py:~/work/vault/code/vault_py/apis:~/work/vault/code/
alias ls="eza --icons --group-directories-first -a"
alias ll="eza --icons --group-directories-first -la -snew"


#control the terminal:
# stty -ixon


# remove alias to ag
unalias -m ag
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

export FZF_DEFAULT_OPTS='--tiebreak=end'
if type fd &> /dev/null; then
	export FZF_DEFAULT_COMMAND="fd --type file --color=always"
	export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --ansi"
elif type ag &> /dev/null; then
	export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -Ht d . $HOME"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
export PYTHON_CONFIGURE_OPTS="--enable-shared --enable-loadable-sqlite-extensions"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#export PYENV_ROOT="${HOME}/.pyenv"
#if [ -d ${PYENV_ROOT} ] ; then
#	export PATH="${PYENV_ROOT}/bin:$PATH"
#	eval "$(pyenv init --path)"
#	eval "$(pyenv init -)"
#fi


enable-fzf-tab

# bind ctrl + space to execute current auto suggestion
bindkey '^ ' autosuggest-execute

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
