if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

set fish_greeting

alias ls="exa -g --icons"
alias ll="exa -l -g --icons"
alias lt="ll --tree --level=2 -a"
alias lta="ll --tree -a"
