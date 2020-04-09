#!/bin/sh
git clean -fdx
# -d means recursive
# -f means force, without it 'clean' not delete files or directories
# -x means don't use standard ignore rules as .gitignore files