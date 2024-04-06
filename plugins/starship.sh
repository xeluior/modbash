# install
if ! which starship &>/dev/null; then
  curl -sS https://starship.rs/install.sh | sh -s --bin-dir="$HOME/.local/bin"
fi

# setup
optional_require "bash-preexec"
eval "$(starship init bash)"
