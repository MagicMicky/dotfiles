#!/usr/bin/env bash

# OUTDATED

#Move to right place
cd "$(dirname "${BASH_SOURCE}")";

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

ln -s ../zpreztoenv ~/.zsh.d/zpreztoenv
ln -s ../zcustomenv ~/.zsh.d/zcustomenv

patch -p1 ~/.zprezto/runcoms/zpreztorc zpreztorc.diff

#Install docker completion
mkdir ~/.zcompletion
wget https://github.com/docker/machine/raw/master/contrib/completion/zsh/_docker-machine ~/.zcompletion/
wget https://github.com/docker/compose/raw/master/contrib/completion/zsh/_docker-compose ~/.zcompletion
wget https://github.com/docker/cli/raw/master/contrib/completion/zsh/_docker ~/.zcompletion

