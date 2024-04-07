plugin_dir="${XDG_DATA_HOME:-"$HOME/.local/share"}/modbash/plugins"
loaded_plugins=()

path () {
  # prepend or append a new, unique PATH entry
  local IFS=':'
  local action="$1"
  local dir="$2"
  local replace="$3"
  local path

  read -a path <<<"$PATH"
  remove () {
    local found
    declare -i found 
    found=1
    for ((i=0; i<${#path[@]}; i+=1)); do
      if [[ "${path[$i]}" == "$1" ]]; then
        if [[ ! -z "$replace" ]]; then
          unset path[$i]
        fi
        found=0
      fi
    done

    # replace is set and it was found, or it wasn't found at all
    if [[ ( ! -z "$replace" && $found -eq 0 ) || $found -eq 1 ]]; then
      return 0
    else
      return 1
    fi
  }
  
  contains () {
    local query="$1"
    local p
    shift

    for p in "$@"; do
      [[ "$p" == "$query" ]] && return 0
    done
    return 1
  }

  case "$1" in
    'prepend')
      remove "$dir" && path=("$dir" "${path[@]}")
      ;;
    'append' | '+=')
      remove "$dir" && path+=("$dir")
      ;;
    'normalize')
      local tmppath=()
      local p
      for p in "${path[@]}"; do
        if ! contains "$p" "${tmppath[@]}"; then
          tmppath+=("$p")
        fi
      done
      path=("${tmppath[@]}")
      unset p tmppath
      ;;
    '')
      for p in "${path[@]}"; do
        echo "$p"
      done
      ;;
  esac

  export PATH="${path[*]}"
  unset path remove contains
}

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
