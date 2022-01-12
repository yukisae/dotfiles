#!/bin/bash

set -x

SOCK_SYMLINK=${SOCK_SYMLINK:-${HOME}/.ssh/ssh-auth-sock}


if [ -L "${SOCK_SYMLINK}" ]; then
  SOCK=$(readlink "${SOCK_SYMLINK}")
  if [ ! -S "${SOCK}" ]; then
    rm -f "${SOCK_SYMLINK}"
  else
    exit 1
  fi
fi

SSH_AUTH_SOCK=`ssh-agent | grep SSH_AUTH_SOCK | sed 's|^SSH_AUTH_SOCK=\(.*\); .*|\1|'`
ln -s "${SSH_AUTH_SOCK}" "${SOCK_SYMLINK}"
