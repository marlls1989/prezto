# Integrates X11 clipboard with zsh using emacs keybinds
# Based on https://unix.stackexchange.com/questions/51933/zsh-copy-and-paste-like-emacs

# return if not on x11
if [[ -z $DISPLAY ]]; then
		return 1
fi

# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

x-copy-region-as-kill () {
  zle copy-region-as-kill
  print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-copy-region-as-kill

x-kill-region () {
  zle kill-region
  print -rn $CUTBUFFER | xsel -i -b
}
zle -N x-kill-region

x-yank () {
  CUTBUFFER=$(xsel -o -b </dev/null)
  zle yank
	
}
zle -N x-yank

bindkey -e '\ew' x-copy-region-as-kill
bindkey -e '^W' x-kill-region
bindkey -e '^Y' x-yank
