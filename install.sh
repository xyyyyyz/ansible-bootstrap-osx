#!/usr/bin/env bash

set -eu

if ! command -v cc >/dev/null; then
  echo "Installing xcode ..."
  xcode-select --install 
  # installation continues in gui, so quit now
  # also installs git, python etc https://mac.install.guide/commandlinetools/8.html
  exit 0
else
  echo "Xcode already installed. Skipping."
fi

# upgrade pip
if ! pip3 list | grep -i ansible >/dev/null; then
  echo "Installing ansible ..."
  python3 -m pip install --upgrade pip

  pip3 install ansible
else
  echo "has ansible, skip ansible install"
fi

# set to path as backup
export PATH=$PATH:~/Library/Python/3.8/bin

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml -i hosts --ask-become-pass -vv --tags $1
