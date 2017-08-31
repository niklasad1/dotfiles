#--------------------ENV Variables---------------------------------------------#
export LANG=en_US.UTF-8 # UTF8
export TERM="xterm-256color" # 256 color schemes support
export EDITOR=vim
export SSH_KEY_PATH="~/.ssh/dsa_id" # ssh key
export VIMRC=$HOME/.vimrc
#-----------------------------------------------------------------------------#


#---------------------OH-MY-ZSH SETTINGS------- ------------------------------#

#Path to your oh-my-zsh installation
export ZSH=/home/niado1/.oh-my-zsh 

# Path to .zshrc 
export ZSHRC=$HOME/.zshrc

# autostart tmux
# export ZSH_TMUX_AUTOSTART="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Set name of the theme to load.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# plugins 
plugins=(git zsh-autosuggestions ubuntu)

# launch oh-my-zsh
source $ZSH/oh-my-zsh.sh

#-----------------------------------------------------------------------------#


#--------------------ALIASES--------------------------------------------------#
alias "c=xclip -selection clipboard" # copy to clipboard e.g. ls | c
alias "dl=cd ~/Downloads"
#-----------------------------------------------------------------------------#
