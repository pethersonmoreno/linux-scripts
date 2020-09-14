#!/bin/sh
echo "Installing ruby-build plugin to rbenv"
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build