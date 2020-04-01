
# Sources
# - Docs
#   * http://zsh.sourceforge.net/Doc/Release/Options.html
# - Examples
#   * https://github.com/romkatv/zsh4humans/
#   * https://github.com/zpm-zsh/core-config

emulate zsh                    # restore default options just in case something messed them up

# 16.2.1 Changing Directories
# setopt AUTO_CD                 # `dirname` is equivalent to `cd dirname`
setopt AUTO_PUSHD              # `cd` pushes directories to the directory stack

# 16.2.2 Completion
setopt ALWAYS_TO_END           # full completions move cursor to the end
setopt AUTO_PARAM_SLASH        # if completed parameter is a directory, add a trailing slash
setopt COMPLETE_IN_WORD        # complete from the cursor rather than from the end of the word

# 16.2.3 Expansion and Globbing
setopt EXTENDED_GLOB           # more powerful globbing

# 16.2.4 History
setopt EXTENDED_HISTORY        # write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST  # if history needs to be trimmed, evict dups first
setopt HIST_FIND_NO_DUPS       # don't show dups when searching history
setopt HIST_IGNORE_DUPS        # don't add consecutive dups to history
setopt HIST_IGNORE_SPACE       # don't add commands starting with space to history
setopt HIST_VERIFY             # if a command triggers history expansion, show it instead of running
setopt SHARE_HISTORY           # write and import history on every command

# 16.2.6 Input/Output
setopt NO_FLOW_CONTROL         # disable start/stop characters in shell editor
setopt INTERACTIVE_COMMENTS    # allow comments in command line
setopt PATH_DIRS               # perform path search even on command names with slashes

# 16.2.7 Job Control
setopt NO_BG_NICE              # don't nice background jobs

# 16.2.9 Scripts and Functions
setopt C_BASES                 # print hex/oct numbers as 0xFF/077 instead of 16#FF/8#77
setopt MULTIOS                 # allow multiple redirections for the same fd

# 16.2.12 Zle
setopt COMBINING_CHARS
setopt NO_BEEP


# setopt BRACE_CCL
# setopt CORRECT
# setopt NO_CASE_GLOB
# setopt NO_CHECK_JOBS
# setopt NOHUP
# setopt NUMERIC_GLOB_SORT
# unsetopt CLOBBER

# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_REDUCE_BLANKS
# setopt INC_APPEND_HISTORY    # this is default, but set for share_history
# setopt COMPLETE_ALIASES