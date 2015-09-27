#!/bin/sh

set -e

fancy_echo() {
  local fmt="$1"; shift
  printf "\xF0\x9F\x90\x9D  $fmt\n" "$@"
}

run() {
  cd ${0%/*}
  
  fancy_echo "Let's get bizzy!"
  
  curl https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/package.json > package.json
  curl https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/gulpfile.coffee > gulpfile.coffee
  curl https://raw.githubusercontent.com/cdig/cd-module-template/v2/dist/.gitignore > .gitignore
  npm install
  # gulp evolve
  
  fancy_echo "Honey, you're home!"
}

read -p "Upgrade the module in this folder from v1 to v2? (y/n) " yn
case $yn in
  [Yy]* ) run;;
  * ) fancy_echo "Pffffff Fine";;
esac
