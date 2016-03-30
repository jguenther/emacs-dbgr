#!/bin/bash
#EMACSLOADPATH=/usr/local/opt/emacs/share/emacs/25.0.50/lisp
for package in test-simple load-relative loc-changes list-utils; do
  p=$(find $HOME/.emacs.d/elpa -name "$package-*" -type d -mindepth 1 -maxdepth 1|sort|tail -n1)
  EMACSLOADPATH=$EMACSLOADPATH:$p
done
if [[ $1 == '-e' ]]; then
  echo "export EMACSLOADPATH='$EMACSLOADPATH'"
  exit 0
fi
export EMACSLOADPATH

target=$HOME/.emacs.d/site-lisp

sh ./autogen.sh
[ $? -ne 0 ] && echo "error: configure issues!" && exit 1
./configure --with-lispdir=$target/realgud
make && make check
[ $? -ne 0 ] && echo "error: make issues" && exit 1
exit 0
