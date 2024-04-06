# determine NVM_DIR
if [[ -z "$NVM_DIR" ]]; then
  if [[ -z "$XDG_CONFIG_HOME" ]]; then
    NVM_DIR="$HOME/.nvm"
  else
    NVM_DIR="$XDG_CONFIG_HOME/nvm"
  fi
fi

# install
if [[ ! -s "$NVM_DIR/nvm.sh" ]]; then
  nvm_source="${nvm_source:-https://github.com/nvm-sh/nvm.git}"
  git clone "$nvm_source" "$NVM_DIR"
fi

# setup
source "$NVM_DIR/nvm.sh"
source "$NVM_DIR/bash_completion"
