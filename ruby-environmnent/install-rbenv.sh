#!/bin/sh
echo "Installing rbenv"
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo "Adding rbenv bin to PATH"
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
export PATH="$HOME/.rbenv/bin:$PATH"
echo "Adding rbenv init to bash init"
echo 'eval "$(rbenv init -)"' >> ~/.bashrc