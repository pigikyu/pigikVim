# bash
#
git submodule init
git submodule update --init --recursive
ln ~/.vim/.vimrc ~/.vimrc
apt-get install libclang1 libclang-dev cmake python-dev python3-dev mercurial ctags cscope
cd bundle/YouCompleteMe 
./install.sh --clang-completer --gocode-completer
