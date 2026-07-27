if status is-interactive
    set -g fish_greeting ""

    bind ctrl-i ""
    bind ctrl-m ""
    bind ctrl-n complete
    bind ctrl-e complete-and-search

    starship init fish | source
end
