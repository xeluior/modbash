# install
user_install_dir="${XDG_DATA_HOME:-"$HOME/.local/share"}/fzf"
fzf_source="https://github.com/junegunn/fzf.git"
fzf_bin_url="https://github.com/junegunn/fzf/releases/download/0.49.0/fzf-0.49.0-linux_amd64.tar.gz"

if ! which fzf &>/dev/null; then
  curl -fsSL -o- "$fzf_bin_url" | tar -C "$HOME/.local/bin" -xz fzf
  git clone "$fzf_source" "$user_install_dir"
fi

# set keybinds
data_dirs_concat="$XDG_DATA_HOME:$XDG_DATA_DIRS"
IFS=':' read -a data_dirs_array <<<"$data_dirs_concat"

for dir in "${data_dirs_array[@]}"; do
  if [[ -s "$dir/fzf/shell/key-bindings.bash" ]]; then
    source "$dir/fzf/shell/key-bindings.bash"
    break
  fi
done
