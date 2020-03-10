.. image:: https://github.com/lainiwa/dotfiles/workflows/CI/badge.svg
    :target: https://github.com/lainiwa/dotfiles/actions?query=workflow%3ACI

==================
Lainiwa's dotfiles
==================


Installation
############

Automatic installation
======================

Use no hassle installation `script <quick_install.sh>`_::

    sh -c "$(curl 'https://raw.githubusercontent.com/lainiwa/dotfiles/master/quick_install.sh')"


Manual (rather semi-automatic) installation
===========================================

Get the repo::

    git clone https://github.com/lainiwa/dotfiles.git ~/.dotfiles

Bootstrap the configs (create soft links to the configs) in the repo::

    ~/.dotfiles/install

Eagerly load plugins for Z-shell::

    zsh -i -c -- '-zplg-scheduler burst || true'


Stuff I use
###########

This configures the following set of tools:

* **Dotfiles bootstrapper:** dotbot_
* **Window manager and status bar:** i3_ and py3status_
* **File manager:** ranger_
* **Text editor:** `Sublime Text 3`_
* **Terminal multiplexer:** tmux_ and tmuxp_
* **Terminal:** urxvt_
* **Shell and plugin manager:** zsh_ and zinit_ (formerly zplugin)
* **Torrenting:** torrench_ and jackett_

.. _dotbot: https://github.com/anishathalye/dotbot
.. _i3: https://i3wm.org/
.. _py3status: https://github.com/ultrabug/py3status
.. _ranger: https://github.com/ranger/ranger
.. _Sublime Text 3: https://www.sublimetext.com/3
.. _tmux: https://wiki.archlinux.org/index.php/Tmux
.. _tmuxp: https://github.com/tmux-python/tmuxp
.. _urxvt: https://wiki.archlinux.org/index.php/rxvt-unicode
.. _zsh: https://wiki.archlinux.org/index.php/Zsh
.. _zinit: https://github.com/zdharma/zinit
.. _torrench: https://github.com/kryptxy/torrench
.. _jackett: https://github.com/Jackett/Jackett


``my`` scripts and dependencies
#############################

I am storing all functions I'm using in a single bash file ``scripts/my``.
Among them there is a special function to check if dependencies for all functions are installed: just call ``my check_dependencies``.

All dependencies are available on ubuntu via ``apt install``.

You might also want to install some additional software to fully utilize preview facilities of ranger file manager. Have a look at ``ranger/scope.sh`` to see what might be sensible to install.
