# Author: Andrew Chen <yongjhih@gmail.com>
# CC, Creative Commons
#
init:
	ln -fs `pwd`/.vim ~/.vim
	ln -fs `pwd`/.vimrc ~/.vimrc
	ln -fs `pwd`/.bashrc ~/.bashrc
	ln -fs `pwd`/.screenrc ~/.screenrc
	ln -fs `pwd`/bin ~/bin
	ln -fs `pwd`/.andrc ~/.andrc
	ln -fs `pwd`/.andrchoose ~/.andrchoose
	ln -fs `pwd`/.gitconfig.d ~/.gitconfig.d
	ln -fs `pwd`/.gitconfig ~/.gitconfig
#	ln -fs `pwd`/sbin ~/sbin
	ln -fs `pwd`/.config/fish/config.fish ~/.config/fish/config.fish
	ln -fs `pwd`/.config/powerline ~/.config/powerline
	ln -fs `pwd`/powerline.sh ~/powerline.sh

sync:
	git pull
	git push

