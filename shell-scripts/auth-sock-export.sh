#!/bin/bash
if test "$SSH_AUTH_SOCK" ; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

# note: meant to be used with tmux with the command
# set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock
