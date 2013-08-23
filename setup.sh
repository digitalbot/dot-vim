#!/bin/sh

cd `dirname $0`
CURDIR=`pwd`
echo $CURDIR

NOWDATE=`date +%Y-%m-%d-%H-%M`

if [ -d ~/.vim ]; then
    mkdir -p tmp/$NOWDATE
    mv ~/.vim tmp/$NOWDATE
    echo "original .vim mv to $CURDIR/tmp/$NOWDATE"
fi

if [ -f ~/.vimrc ]; then
    mkdir -p tmp/$NOWDATE
    mv ~/.vimrc tmp/$NOWDATE
    echo "original .vimrc mv to $CURDIR/tmp/$NOWDATE"
fi

if [ -f ~/.gvimrc ]; then
    mkdir -p tmp/$NOWDATE
    mv ~/.gvimrc tmp/$NOWDATE
    echo "original .gvimrc mv to $CURDIR/tmp/$NOWDATE"
fi

echo "ln -s $CURDIR/.vim ~/"
echo "ln -s $CURDIR/.vimrc ~/"
echo "ln -s $CURDIR/.gvimrc ~/"
ln -s $CURDIR/.vim ~/
ln -s $CURDIR/.vimrc ~/
ln -s $CURDIR/.gvimrc ~/
