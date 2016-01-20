# environmental variable
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8

export XMODIFIERS=@im=uim
export GTK_IM_MODULE=uim

# to use color
autoload -Uz colors
colors

# vi flavor
bindkey -vi

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# prompt
local p_rhst=""
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]]; then
  local rhost='who am i|sed 's/.*(\(.*\)).*/\1.''
  rhost=${rhost#localhost:}
  rhost=${rhost%%.*}
  p_rhst="%B%F{yellow}($rhost)%f%b"
fi
local p_cdir="%B%F{blue}[%~]%f%b"$'\n'
local p_info="%F{red}[%m]%f"
local p_mark="%B%(?,%F{green},%F{red})%(!,#,>)%f%b"
PROMPT=" $p_cdir$p_rhst$p_info $p_mark "

PROMPT2="%_> "

# word partition
autoload -Uz select-word-style
select-word-style default

# partition charactor
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

######################################

# turn on the function of auto complete
autoload -Uz compinit
compinit

# case-insensitive on auto complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# parent directory complete
zstyle ':completion:*' ignore-parents parent pwd ..

# complete on sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# complete processes name on ps
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

######################################

# vcs_info

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes true
function _update_vcs_info_msg() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

#####################################

# option

# show japanese name
setopt print_eight_bit

# invalidation beep
setopt no_beep

# invalidation flow control
setopt no_flow_control

# '#' is comment
setopt interactive_comments

# move directory only the name
setopt auto_cd

# can't make duplicate directory
setopt pushd_ignore_dups

# auto pushd on cd
setopt auto_pushd

# complete path name on '='
setopt magic_equal_subst

# share history in difference zsh window
setopt share_history

# doesn't rest duplicate command in history
setopt hist_ignore_all_dups

# delete duplicate older command in history
setopt hist_save_nodups

# doesn't rest command that begin with space in history
setopt hist_ignore_space

# delete extra space at save in history
setopt hist_reduce_blanks

# show candidate list at complete
setopt auto_menu

# expand wild card
setopt extended_glob

#####################################

# alias

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'

if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

alias ctags="`brew --prefix`/bin/ctags"

#####################################

case ${OSTYPE} in
    darwin*)
        # for OSX
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        # for Linux
        ;;
esac

# vim:set ft=zsh:

# Default Editor
export EDITOR="/usr/local/bin/vim"
