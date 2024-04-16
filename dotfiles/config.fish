set fish_greeting

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if not status --is-login
   if status --is-interactive
      source (starship init fish --print-full-init | psub)
   end
end

function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

bind ! __history_previous_command

function history
    builtin history --show-time='%F %T '
end

alias ls='exa -al --color=always --group-directories-first --icons'
alias la='exa -a --color=always --group-directories-first --icons'
alias ll='exa -l --color=always --group-directories-first --icons'
alias lt='exa -aT --color=always --group-directories-first --icons'
alias l.="exa -a | egrep '^\.'"
alias ip="ip -color"

alias cat='bat --style header --style rule --style snip --style changes --style header'

alias vim="nvim"

# set -Ux CARGO_HOME $HOME/.cargo
# set -Ux RUST_SRC_PATH /usr/local/src/rust/src

# set -U fish_user_paths $CARGO_HOME/bin $fish_user_paths
# set -U fish_user_paths $HOME/.local/share/bin $fish_user_paths

# Load node
# load_nvm > /dev/stderr

## Run pfetch if session is interactive
# if status --is-interactive && type -q pfetch
#    PF_INFO="ascii title os host kernel uptime pkgs shell" pfetch
# end

if status --is-interactive && type -q neofetch
  neofetch
end
