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
python3 -m pip install --upgrade pip

pip3 install ansible

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml -i hosts --ask-become-pass -vv
