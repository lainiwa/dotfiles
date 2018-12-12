# Lainiwa's dotfiles

## Installation
My dotfiles use [dotbot](https://github.com/anishathalye/dotbot). This tool lets you install your dotfiles as easy as:
```sh
if [ ! -d ~/.dotfiles ]; then
    git clone git@github.com:lainiwa/dotfiles.git ~/.dotfiles
fi
~/.dotfiles/install
```

## Tools list
This configures the following set of tools:

* [i3](https://i3wm.org/) and [py3status](https://github.com/ultrabug/py3status)
* [ranger](https://github.com/ranger/ranger)
* [Sublime Text 3](https://www.sublimetext.com/3)
* [tmux](https://wiki.archlinux.org/index.php/Tmux) and [tmuxp](https://github.com/tmux-python/tmuxp)
* [urxvt](https://wiki.archlinux.org/index.php/rxvt-unicode)
* [zsh](https://wiki.archlinux.org/index.php/Zsh) and [zplugin](https://github.com/zdharma/zplugin)
* [torrench](https://github.com/kryptxy/torrench)


## Dependencies
I am storing all functions I'm using in a single bash file `scripts/my`,
calling them in a manner `my function_name [arg1 [arg2 [...]]]`.
It has a special function to check if dependencies for all functions are installed: just call `my dependencies check`. It has other options also, which you might check by either looking at source code, or using autocompletion.

All dependencies are available on ubuntu via apt.

You might also want to install some additional software to fully utilize preview facilities of ranger file manager. Have a look at `ranger/scope.sh` to see what might be sensible to install.
