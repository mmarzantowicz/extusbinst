
# Avoid bash errors about undeclared variables
declare color_none= color_bold= color_red= color_green= color_yellow= color_blue=

# Enable colored output in terminal
enable_colors() {
    if [[ -t 1 && -t 2 ]]; then
        if tput setaf 0 &> /dev/null; then
            color_none=$(tput sgr0)
            color_bold=$(tput bold)
            color_red=${color_bold}$(tput setaf 1)
            color_green=${color_bold}$(tput setaf 2)
            color_yellow=${color_bold}$(tput setaf 3)
            color_blue=${color_bold}$(tput setaf 4)
        else
            color_none="\e[1;0m"
            color_bold="\e[1;1m"
            color_red="${color_bold}\e[1;31m"
            color_green="${color_bold}\e[1;32m"
            color_yellow="${color_bold}\e[1;33m"
            color_blue="${color_bold}\e[1;34m"
        fi
    fi
}
