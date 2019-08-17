# Lainiwa's dotfiles


## Installation
Use no hassle installation [script](quick_install.sh):
```sh
sh -c "$(curl 'https://raw.githubusercontent.com/lainiwa/dotfiles/master/quick_install.sh')"
```

... or (if the idea of piping `curl` to shell interpreter offends you) go with this snippet:
```sh
git clone https://github.com/lainiwa/dotfiles.git ~/.dotfiles
~/.dotfiles/install
zsh -i -c -- '-zplg-scheduler burst || true'
```

Either of these would install config files for only the tools you have installed on your system.


## Stuff I use
This configures the following set of tools:

* **Dotfiles bootstrapper:** [dotbot](https://github.com/anishathalye/dotbot)
* **Window manager and status bar:** [i3](https://i3wm.org/) and [py3status](https://github.com/ultrabug/py3status)
* **File manager:** [ranger](https://github.com/ranger/ranger)
* **Text editor:** [Sublime Text 3](https://www.sublimetext.com/3)
* **Terminal multiplexer:** [tmux](https://wiki.archlinux.org/index.php/Tmux) and [tmuxp](https://github.com/tmux-python/tmuxp)
* **Terminal:** [urxvt](https://wiki.archlinux.org/index.php/rxvt-unicode)
* **Shell and plugin manager:** [zsh](https://wiki.archlinux.org/index.php/Zsh) and [zplugin](https://github.com/zdharma/zplugin)
* **Torrenting:** [torrench](https://github.com/kryptxy/torrench) and [jackett](https://github.com/Jackett/Jackett)


## `my` scripts and dependencies
I am storing all functions I'm using in a single bash file `scripts/my`.
Among them there is a special function to check if dependencies for all functions are installed: just call `my check_dependencies`.

All dependencies are available on ubuntu via `apt install`.

You might also want to install some additional software to fully utilize preview facilities of ranger file manager. Have a look at `ranger/scope.sh` to see what might be sensible to install.
