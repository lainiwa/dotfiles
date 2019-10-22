
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
_add_to_path "/snap/bin"
_add_to_path "${HOME}/bin"
_add_to_path "${HOME}/.local/bin"
_add_to_path "${HOME}/scripts"
_add_to_path "${HOME}/.cargo/bin"
_add_to_path "${HOME}/.cabal/bin"
export GOPATH="${HOME}/go"
_add_to_path "${GOPATH}/bin"
export PYENV_ROOT="${HOME}/.pyenv"
_add_to_path "${PYENV_ROOT}/bin"
_add_to_path "${HOME}/.poetry/bin"

unset -f _add_to_path
