
# Standardized $0 Handling
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Then ${0:h} to get plugin’s directory

# Functions Directory
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#funcs-dir
if [[ $PMSPEC != *f* ]] {
    fpath+=( "${0:h}/functions" )
}

# Binaries Directory:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#bin-dir
if [[ $PMSPEC != *b* ]] {
    path+=( "${0:h}/bin" )
}
