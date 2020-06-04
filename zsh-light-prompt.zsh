# set up PROMPT and RPOMPT
setopt prompt_subst
autoload -Uz promptinit
promptinit

export PROMPT='%(?.%F{green} ✔ .%F{red} 𝙭 %?)%f %B%F{12}%1~%f%b %# '
export RPROMPT='$vcs_info_msg_0_ ${vim_mode}'

# set up vcs_info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:*' disable bzr cdv darcs mtn svk tla cvs svn
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' stagedstr "%F{yellow} 𝓼 %f"
zstyle ':vcs_info:*' unstagedstr "%F{red} 𝓾 %f"
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:git:*' formats '%F{14}%B[%r/%S]%f%u%c%m(%b)'
zstyle ':vcs_info:git:*' actionformats '%F{14}%B[%r/%S]%f%u%c%m(%b|%a)'

# create vim_mode indicator for RPROMPT
vim_ins_mode="%F{green}%B𝓲 %f"
vim_cmd_mode="%F{blue}%B𝓬 %f"
vim_mode=$vim_ins_mode

zle -A zle-keymap-select _lp_saved_zle-keymap-select
function _lp_zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
  if (( ${+widgets[_lp_saved_zle-keymap-select]} )); then
    zle _lp_saved_zle-keymap-select
  fi
}
zle -N zle-keymap-select _lp_zle-keymap-select

zle -A zle-line-finish _lp_saved_zle-line-finish
function _lp_zle-line-finish {
  vim_mode=$vim_ins_mode
  if (( ${+widgets[_lp_saved_zle-line-finish]} )); then
    zle _lp_saved_zle-line-finish
  fi
}
zle -N zle-line-finish _lp_zle-line-finish
