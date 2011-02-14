init:
	mv ~/.vim /tmp/
	ln -fs `pwd`/.vim ~/.vim
	ln -fs `pwd`/.vimrc ~/.vimrc
	ln -fs `pwd`/.bashrc ~/.bashrc
	ln -fs `pwd`/.screenrc ~/.screenrc
	mv ~/bin /tmp/
	ln -fs `pwd`/bin ~/bin
	ln -fs `pwd`/.andrc ~/.andrc
	ln -fs `pwd`/.andrchoose ~/.andrchoose
#	ln -fs `pwd`/sbin ~/sbin

sync:
	git pull
	git push

