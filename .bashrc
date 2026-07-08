#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#------ Source Aliases -----
source .config/shell/aliases

#------ Text Prompt ------
PS1='\D{%H:%M:%S}  [\u: \w ] => '

#----- CWD Update Hyprland -------
hypr_cwd_update() {
    pwd > "${XDG_RUNTIME_DIR}/hypr-cwd"
}

PROMPT_COMMAND=hypr_cwd_update

