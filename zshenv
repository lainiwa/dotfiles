
_add_to_path() {
    local dir=$1
    if [[ -d ${dir} && ! ${PATH} =~ (:|^)${dir}(:|$) ]]; then
        if [[ ${dir} =~ ^/home ]]; then
            export PATH=${dir}:${PATH}
        else
            export PATH=${PATH}:${dir}
        fi
    fi
}
_add_to_path "/sbin"
_add_to_path "${HOME}/bin"
_add_to_path "${HOME}/.local/bin"
_add_to_path "${HOME}/scripts"
_add_to_path "${HOME}/.cargo/bin"
_add_to_path "${HOME}/.cabal/bin"
_add_to_path "${HOME}/.kiss/usr/bin"

unset -f _add_to_path


# The location to install packages (Optional).
# Default: /
export KISS_ROOT="${HOME}/.kiss"

# Repositories to use (Required).
# Colon separated like '$PATH'.
# Repositories will be search in order.
# Default: ''
export KISS_PATH="${HOME}/packages/core:${HOME}/packages/extra:${HOME}/packages/xorg:${HOME}/packages/public"

