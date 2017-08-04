#!/usr/bin/env bash

#Move to right place
cd "$(dirname "${BASH_SOURCE}")";

git clone https://github.com/vim-airline/vim-airline ~/.vim-airline
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim-airline-themes
mkdir ~/.vim ~/.vim/autoload ~/.vim/colors ~/.vim/doc ~/.vim/plugin
ln -s ~/.vim-airline/autoload/airline ~/.vim/autoload/airline
ln -s ~/.vim-airline/autoload/airline.vim ~/.vim/autoload/airline.vim

ln -s ~/.vim-airline/doc/airline.txt ~/.vim/doc/airline.txt
ln -s ~/.vim-airline/doc/airline-themes.txt ~/.vim/doc/airline-themes.txt

ln -s ~/.vim-airline/plugin/airline.vim ~/.vim/plugin/airline.vim
ln -s ~/.vim-airline/plugin/airline-themes.vim ~/.vim/plugin/airline-themes.vim

cp ./vim/autoload/airline/themes/* ~/.vim/autoload/airline/themes
cp ./vim/colors/luna.vim ~/.vim/colors/luna.vim
cp ./vim/doc/airline-themes.txt ~/.vim/doc/airline-themes.txt
cp ./vim/plugin/tabline.vim ~/.vim/plugin/tabline.vim
cp ./vimrc ~/.vimrc
cp ./vimrc_powerline ~/.vimrc_powerline
