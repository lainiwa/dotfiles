
_add_to_path() {
    local dir=${1}
    if [[ -d ${dir} && ! ${PATH} =~ (:|^)${dir}(:|$) ]]; then
        if [[ ${dir} =~ ^/home ]]; then
            export PATH=${dir}${PATH:+:}${PATH}
        else
            export PATH=${PATH}${PATH:+:}${dir}
        fi
    fi
}

_try_source() {
    local file_path=${1}
    if [[ -f ${file_path} ]]; then
       source "${file_path}"
    fi
}

_add_to_path "/sbin"
_add_to_path "/snap/bin"
_add_to_path "${HOME}/bin"
_add_to_path "${HOME}/.local/bin"
_add_to_path "${HOME}/scripts"

# Pkgsrc paths
_add_to_path "/usr/pkg/bin"
_add_to_path "/usr/pkg/sbin"

# PostgreSQL
export PGDATA=/usr/local/pgsql/data
export PGUSER=postgres
_add_to_path "/usr/local/pgsql/bin/"

# Haskell
_add_to_path "${HOME}/.cargo/bin"
_add_to_path "${HOME}/.cabal/bin"

# Golang
export GOPATH="${HOME}/go"
_add_to_path "${GOPATH}/bin"
_add_to_path "${HOME}/.go/bin"
_add_to_path "/usr/local/go/bin"

# Python
export PYENV_ROOT="${HOME}/.pyenv"
_add_to_path "${PYENV_ROOT}/bin"
_add_to_path "${HOME}/.poetry/bin"

# Nix
_try_source "${HOME}/.nix-profile/etc/profile.d/nix.sh"
export NIX_PATH=${HOME}/.nix-defexpr/channels${NIX_PATH:+:}${NIX_PATH}

# Guix
export GUIX_PROFILE="${HOME}/.guix-profile"
_try_source "${GUIX_PROFILE}/etc/profile"
export GUIX_LOCPATH=${GUIX_PROFILE}/lib/locale
export GUIX_GTK3_PATH=${GUIX_PROFILE}/lib/gtk-3.0${GUIX_GTK3_PATH:+:}${GUIX_GTK3_PATH}
export GUIX_PACKAGE_PATH=${HOME}/.dotfiles/guix-packages
_add_to_path "${GUIX_PROFILE}/bin"
_add_to_path "${GUIX_PROFILE}/sbin"
_add_to_path "${HOME}/.config/guix/current/bin"

# Linuxbrew
_add_to_path "${HOME}/.linuxbrew/bin"

# Emacs
_add_to_path "${HOME}/.emacs.d/bin"
_add_to_path "${HOME}/.config/emacs/bin"

# Turn on aliases for hosts
export HOSTALIASES=${HOME}/.hosts

# Private settings
_try_source "${HOME}/.dotfiles-private/env.zsh"

# Add snap .desktop files to rofi menu
export XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
export XDG_DATA_DIRS=/var/lib/snapd/desktop:${XDG_DATA_DIRS}
export XDG_DATA_DIRS=${HOME}/.local/share:${XDG_DATA_DIRS}

unset -f _add_to_path
unset -f _try_source
