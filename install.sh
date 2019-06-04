#!/bin/bash

function main() {
    if [[ -L "$HOME/.emacs.el" ]]; then
        check_existing_symlink
    else
        create_symlink_if_possible
    fi
}

function check_existing_symlink() {
    local target=$(readlink -f $HOME/.emacs.el)

    if [[ "$target" != "`chemacs_home`.emacs.el" ]]; then
        warn "~/.emacs.el symlink points elsewhere -> $target"
    else
        ok "chemacs already linked, you're all good."
    fi
}

function create_symlink_if_possible() {
    if [[ -e "$HOME/.emacs.el" ]]; then
        warn "chemacs can't be installed, ~/.emacs.el is in the way"
    else
        ok "Creating symlink ~/.emacs.el -> `chemacs_home`.emacs.el"
        ln -s "`chemacs_home`.emacs.el" "$HOME"
    fi
}

function chemacs_home() {
    cd `dirname "${BASH_SOURCE[0]}"` && echo "`pwd`/$1"
}

function warn() {
    echo -e "WARN\t$1"
}
function ok()   {
    echo -e "OK\t$1"
}


main
