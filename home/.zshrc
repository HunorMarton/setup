# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="skovhus" # simple, kennethreitz, agnoster, robbyrussell

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew docker git npm vscode)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=(/usr/local/share/zsh-completions $fpath)


# =========================================
# User configuration
# =========================================

alias ls='ls -a'
alias shell-source="source ~/.zshrc"
alias shell-add-alias="stt ~/.zshrc"
alias unu-delete-dot-unu-folder="rm -rf ~/.unu/"
alias unu-stack-complete-rerun='./run down && rm -rf ~/.unu/ && ./bin/update.sh && ./run'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Command}}"'
alias mongo-shell-login="mongo --ssl --sslAllowInvalidCertificates --sslAllowInvalidHostnames -u user -p password --authenticationDatabase 'admin'"
alias portainer="docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer && open http://localhost:9000/"
alias webserver="echo http://localhost:8000 && python -m SimpleHTTPServer 8000"
# Docker super-logs
function docker-ps-with-grep() {
    if [ "$1" != "" ]
    then
        result=$(docker ps --format "table {{.Names}}" | grep "$1")
        if [ "$result" != "" ]
        then
            docker logs -f $result
        else
            docker logs -f $1
        fi
    else
        echo "Please pass something. e.g. dlog sockend"
    fi
}
alias dlog="docker-ps-with-grep"

export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8

# Setting things because of node@10
export PATH=/usr/local/opt/node@10/bin:$PATH #
export LDFLAGS=-L/usr/local/opt/node@10/lib
export CPPFLAGS=-I/usr/local/opt/node@10/include

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='code'
else
    export EDITOR='nano'
fi
