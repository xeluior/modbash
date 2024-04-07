# ModBash

Writing good bash rc files is a messy process. Moreso when you are sourcing files provided by packages. Distro maintainers may make this process easier for the average case by placing scripts in a /etc/profile.d folder to be sourced where needed. This is a somewhat "shotgun" approach. All files in this directory are sourced and there is little control that is maintained by the user for deciding which of the modules they would actually like activated. For this reason, this directory is kept rather sparse. Additionally, it does not make sense to include files that relate to per-user software installations in this directory.

For these reasons, and my desire for a clean looking bashrc, I wrote modbash, a module system for bash, to clean up my bashrc and keep concerns seperate when seting up my environment. The plugins are simple scripts in the plugins/ directory that can be loaded by adding them to the filename (modulo extension) to the plugins array prior to sourcing mod.bash. You can easily write your own scripts by adding more files to the plugins directory.

# Installation

Simply clone this repo to $XDG_DATA_HOME/modbash/

# Usage

In your bashrc, add the names of the plugins you want to load to the plugins array then source mod.bash. Below is an example.

```bash
plugins=(nvm fzf)
source "$XDG_DATA_HOME/modbash/mod.bash"
```

Due to the system of `require`s that modbash supports, additional plugins may get loaded beyond what was specified in the plugins array. After sourcing mod.bash, you can check the `loaded_plugins` array to see what was actually loaded.

# Contributing

If you want to write your own plugins, simply add a new file to the plugins/ directory. It will get sourced if it's name (without the .sh extension) is listed in the user's plugins array. There are a few functions available for use in plugin files to interact with the modbash system.

- `load <name>`: source the plugin with `name` and add it to the `loaded_plugins` array. It is probably better to use `require`
- `require <name>`: source the plugin with `name` if and only if it has not already been loaded
- `optional_require <name>`: load the plugin with `name` if it has been specified by the user in the `plugin` array and has not already been loaded
- `path normalize`: removes duplicate entries from PATH
