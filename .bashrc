#### 
###    .o8                          oooo                           
##    "888                          `888                           
#      888oooo.   .oooo.    .oooo.o  888 .oo.   oooo d8b  .ooooo.  
#      d88' `88b `P  )88b  d88(  "8  888P"Y88b  `888""8P d88' `"Y8 
#      888   888  .oP"888  `"Y88b.   888   888   888     888       
# .o.  888   888 d8(  888  o.  )88b  888   888   888     888   .o8 
# Y8P  `Y8bod8P' `Y888""8o 8""888P' o888o o888o d888b    `Y8bod8P' 

caps () {
  xmodmap $HOME/.caps-esc-swap
}

gitnow () {
  git pull --quiet
  git add . 
  if [[ $# > 0 ]]
  then 
    echo "Using user-provided commit message"
    git commit -m "$1"
  else
    echo "No commit message, filling in"
    git commit -m "Updating"
  fi
  git push --quiet
}

dtf () {
  git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME add $1 && \
  git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME commit -m "Updating $1" && \
  git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME push --quiet
}

pw () {
  LENGTH="15"
  [[ "$#" -gt 0 ]] && LENGTH=$1
  echo 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890@!#$%^&*()_-+=[]{}:;,.<>' | fold -w1 | shuf -r | tr -d "\n" | head -c $LENGTH | tr -d "\n" | tee $CLIPBOARD
}

kanban () {
while (( "$#" )); do
  case "$1" in
    -w|--wod)
      OUTPUT="#### Morning WOD\n$(date '+%Y/%m/%d')\n"$(cat "$HOME/kanban/wod")
      echo -e "$OUTPUT" | tee "$CLIPBOARD"
      shift ;;
    *)
      echo "Currently only the options -w|--wod are supported"
      shift ;;
  esac
done
}

## Special settings for Windows 
if [[ $OSTYPE =~ 'msys'|'cygwin' ]]
then
  ## Enable symlink support in MS Windows
  ## see: https://www.joshkel.com/2018/01/18/symlinks-in-windows/
  export MSYS="winsymlinks:nativestrict"
  export PAGER='less'
  export OS='WIN'
  export CODE_KEYBINDING_DIR='/c/Users/jaspe/AppData/Roaming/Code/User'
  alias az='/c/Program\ Files\ \(x86\)/Microsoft\ SDKs/Azure/CLI2/wbin/az.cmd'
  alias firefox='/c/Program\ Files/Mozilla\ Firefox/firefox.exe'
  alias python="winpty python.exe"
  alias la='ls --group-directories-first --all --color=auto'
  alias ll='ls --group-directories-first --format=long --color=auto'
  alias ls='ls --group-directories-first --color=auto'
fi

## Special settings for Mac OS X
if [[ $OSTYPE =~ 'darwin' ]]
then
  export HISTSIZE=99999
  export HISTFILESIZE=99999
  export BROWSER='open -a /Applications/Firefox.app' # used by Newsboat
  export PAGER='most'
  export PROMPT_COMMAND='
    printf "  \e[${COLOR2}m`pwd`\e[90m "
    CONTENTS=$(exa --reverse --sort=modified | tr "\n" " ")
    if [ ${#CONTENTS} -gt $COLUMNS ]
    then
      echo -n $CONTENTS | head -c $(expr $COLUMNS "-" $(pwd | wc -m) "-" 6)
      echo " ..."
    else 
      echo $CONTENTS
    fi'
  export OS='MAC'
  export CLIPBOARD='pbcopy'
  export CODE_KEYBINDING_DIR="/Users/$USER/Library/Application Support/Code/User"
  alias la='exa --group-directories-first -a'
  alias ls='exa --group-directories-first'
  alias ll='exa --group-directories-first -l'
  [[ $PATH =~ '/Library/Frameworks/Python.framework/Versions/3.7/bin' ]] || export PATH=$PATH':/Library/Frameworks/Python.framework/Versions/3.7/bin'
  [[ $PATH =~ "$HOME/.cargo/bin" ]] || export PATH=$PATH":$HOME/.cargo/bin"
  [[ $PATH =~ "$HOME/.npm-global/bin" ]] || export PATH=$PATH":$HOME/.npm-global/bin"
  alias python='python3'
  alias pip='pip3'
fi

## Special settings for Linux
if [[ $OSTYPE =~ 'linux' ]]
then
  export HISTSIZE=-1
  export HISTFILESIZE=-1
  export OS='LX'
  export CLIPBOARD='xclip -selection clipboard'
  export BROWSER='firefox'
  export PAGER='most'
  export CODE_KEYBINDING_DIR="$HOME/.config/Code/User"
  export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1           # PowerShell Core support 
  alias k='konsole --profile $(shuf -n1 -e $(ls $HOME/.local/share/konsole *.profile)) &> /dev/null &'
  alias kl='konsole --profile $(shuf -n1 $HOME/.local/share/konsole/lightprofiles) &> /dev/null &'
  alias cfgpb='$EDITOR $HOME/.config/polybar/default.polybar'
  alias cfgi3='$EDITOR $HOME/.config/i3/config'
  alias cfgca='$EDITOR $HOME/.config/castero/castero.conf'
  alias cfgqt='$EDITOR $HOME/.config/qtile/config.py'
  alias la='lsd --group-dirs --icon-theme=unicode -a'
  alias ls='lsd --group-dirs --icon-theme=unicode '
  alias ll='lsd --group-dirs --icon-theme=unicode  -l'
  . yakuake-blurry-bg-fix
  alias lla='lsd --group-dirs first --icon-theme=unicode  -la'
  # export PROMPT_COMMAND='
  # printf "  \e[${COLOR2}m`pwd`\e[90m "
  # CONTENTS=$(lsd --timesort | tr "\n" " ")
  # if [ ${#CONTENTS} -gt $COLUMNS ]
  # then
  #   echo -n $CONTENTS | head -c $(expr $COLUMNS "-" $(pwd | wc -m) "-" 6)
  #   echo " ..."
  # else 
  #   echo $CONTENTS
  # fi'
fi

alias cp="cp -i"        # confirm before overwriting something
alias df='df -h'        # human-readable sizes
alias free='free -m'    # show sizes in MB
alias dotfile='git --git-dir=$HOME/dotfiles/.git --work-tree=$PWD'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias grep='grep --color=auto -d recurse'
alias np='nano -w PKGBUILD'
alias more='less'
alias refresh-prompt='export PS1="\e[$(shuf -en 1 91 92 93 94 95 96)m$ \e[39m"'
alias nflight='for n in {1..6}; do neofetch --colors $n 0 0 $n 0 0 --ascii_colors $n; done;'
alias nfdark='for n in {1..6}; do neofetch --colors $n 255 255 $n 255 255 --ascii_colors $n; done;'
alias cfgnb='$EDITOR $HOME/.config/newsboat/config'
alias cfgnbu='$EDITOR $HOME/.config/newsboat/urls'

COLOR1=$(shuf -en 1 91 92 93 94 95 96)
COLOR2=$(shuf -en 1 31 32 33 34 35 36)

export BAT_PAGER='less'
export EDITOR='vim'
export MOST_INIT="$HOME/.mostrc"
export PS1="\e[${COLOR1}m$ \e[39m"
export TERM='xterm-256color'

[[ $PATH =~ '/usr/src/bin' ]] || export PATH=$PATH':/usr/src/bin'
[[ $PATH =~ "$HOME/Scripts" ]] || export PATH=$PATH":$HOME/Scripts"
