
setopt PROMPT_SUBST # allow expansion in prompts

autoload -U promptinit # initialize the prompt system promptinit
promptinit

# https://github.com/agkozak/agkozak-zsh-theme
_is_ssh() {
  if [[ -n $SSH_CONNECTION ]] || [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]; then
    true
  else
    case $EUID in
      0)
        case $(ps -o comm= -p $PPID) in
          sshd|*/sshd) true  ;;
                    *) false ;;
        esac
        ;;
      *) false ;;
    esac
  fi
}
_is_ssh && host='%F{red}@%F{yellow}%m' || host=''

PS1="%B%F{yellow}%n${host}%F{red}: %F{green}%~ %F{red}%#%f%b "
PS2="%_> "
RPS1="%B%F{yellow}%(?..(%?%))%f%b"

unset -f _is_ssh



