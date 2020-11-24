.. image:: https://github.com/lainiwa/dotfiles/workflows/CI/badge.svg
    :target: https://github.com/lainiwa/dotfiles/actions?query=workflow%3ACI

==================
Lainiwa's dotfiles
==================

Minimal requirements
####################

==========  =====================
Dependency  Rationale
==========  =====================
``python``  Symlinking via dotbot
``git``     Cloning dotfiles
==========  =====================


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

Optional: pre-load plugins for Z-shell::

    zsh -i -c exit


Stuff I use
###########

This configures the following set of tools:

* **Dotfiles bootstrapper:** dotbot_
* **Window manager and status bar:** i3_ and py3status_
* **File managers:** ranger_ and nnn_
* **Text editor:** `Sublime Text 3`_
* **Terminal multiplexer:** tmux_ and tmuxp_
* **Terminal:** urxvt_
* **Shell and plugin manager:** zsh_ and zpm_
* **Music organizer:** beets_
* **Image viewer:** sxiv_
* **Torrenting:** torrench_ and jackett_

.. _dotbot: https://github.com/anishathalye/dotbot
.. _i3: https://i3wm.org/
.. _py3status: https://github.com/ultrabug/py3status
.. _ranger: https://github.com/ranger/ranger
.. _nnn: https://github.com/jarun/nnn
.. _Sublime Text 3: https://www.sublimetext.com/3
.. _tmux: https://wiki.archlinux.org/index.php/Tmux
.. _tmuxp: https://github.com/tmux-python/tmuxp
.. _urxvt: https://wiki.archlinux.org/index.php/rxvt-unicode
.. _zsh: https://wiki.archlinux.org/index.php/Zsh
.. _zinit: https://github.com/zdharma/zinit
.. _zpm: https://github.com/zpm-zsh/zpm
.. _beets: https://github.com/beetbox/beets
.. _sxiv: https://github.com/muennich/sxiv
.. _torrench: https://github.com/kryptxy/torrench
.. _jackett: https://github.com/Jackett/Jackett


Personal scripts
################

`screenshot <scripts/screenshot>`_
==================================
The script I keybind to i3 to make screenshots.

Usage: ``screenshot <full|select|focused>``.

.. raw:: html

   <details>
   <summary><b>Dependencies</b></summary>

* Interpreter:
    - POSIX shell + coreutils
* Screenshot tool:
    - maim_ + xdotool_
    - scrot_
    - graphicsmagick_ + xdotool_
    - imagemagick_ + xdotool_
* Clipboard tool [opt]:
    - xclip_
    - xsel_
* Image lossless optimizer [opt]:
    - optipng_
    - pngcrush_
    - jpegoptim_
* OCR tool [opt]:
    - tesseract_ + tesseract-ocr-rus
* Locks manager [opt]:
    - flock_

.. _maim: https://github.com/naelstrof/maim
.. _scrot: https://github.com/resurrecting-open-source-projects/scrot
.. _xdotool: https://github.com/jordansissel/xdotool
.. _graphicsmagick: http://www.graphicsmagick.org
.. _imagemagick: https://github.com/ImageMagick/ImageMagick
.. _xclip: https://github.com/astrand/xclip
.. _xsel: https://github.com/kfish/xsel
.. _optipng: http://optipng.sourceforge.net/
.. _pngcrush: https://pmt.sourceforge.io/pngcrush/
.. _jpegoptim: http://freshmeat.sourceforge.net/projects/jpegoptim
.. _tesseract: https://github.com/tesseract-ocr/tesseract
.. _flock: https://directory.fsf.org/wiki/Flock

.. raw:: html

   </details>

`wallpaper <scripts/wallpaper>`_
================================
The i3 WM runs this on start.

Usage: ``wallpaper <image_path>``.

.. raw:: html

   <details>
   <summary><b>Dependencies</b></summary>

* Interpreter:
    - POSIX shell + coreutils
* Wallpaper setter:
    - hsetroot_
    - nitrogen_
    - feh_
    - Esetroot (part of eterm_)
    - (xdpyinfo_ or xwininfo_ or xrdb_) and (graphicsmagick_ or imagemagick_)

.. _hsetroot: https://github.com/himdel/hsetroot
.. _nitrogen: https://github.com/l3ib/nitrogen
.. _feh: https://github.com/derf/feh
.. _eterm: https://www.openhub.net/p/eterm
.. _xdpyinfo: https://github.com/freedesktop/xdpyinfo
.. _xwininfo: https://gitlab.freedesktop.org/xorg/app/xwininfo
.. _xrdb: https://gitlab.freedesktop.org/xorg/app/xrdb

.. raw:: html

   </details>

`pastebin <scripts/pastebin>`_
==============================
Upload and download file to public pastebin-like serever.

Usage: type ``pastebin --help`` for instruction.

.. raw:: html

   <details>
   <summary><b>Dependencies</b></summary>

* Interpreter:
    - Bash + coreutils
    - curl_
    - gnupg_ [opt]
    - xclip_ [opt]

.. _curl: https://github.com/curl/curl
.. _gnupg: http://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git

.. raw:: html

   </details>

`my <scripts/my>`_
==================
The snippets I use here and there.

Usage: ``my <snippet>``.

**Dependencies:** lots of them.
Check if dependencies are met with ``my check_dependencies``.
All dependencies are available on ubuntu via ``apt install``.

.. You might also want to install some additional software to fully utilize preview facilities of ranger file manager. Have a look at ``ranger/scope.sh`` to see what might be sensible to install.
