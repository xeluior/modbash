plugin_dir="${XDG_DATA_HOME:-"$HOME/.local/share"}/modbash/plugins"
loaded_plugins=()

load () {
  plugin="$1"
  source "$plugin_dir/$plugin.sh"
  loaded_plugins+=("$plugin")
}

require () {
  plugin="$1"
  if [[ ! "${loaded_plugins[@]}" =~ "$plugin" ]]; then
    load "$plugin"
  fi
}

optional_require () {
  plugin="$1"
  if [[ "${plugins[@]}" =~ "$plugin" ]]; then
    require "$plugin"
  fi
}

for plugin in "${plugins[@]}"; do
  load "$plugin"
done

unset load require optional_require
