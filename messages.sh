plain() {
    local mesg=$1; shift
    printf "${color_bold}    ${mesg}${color_none}\n" "$@" >&1
}

msg() {
    local mesg=$1; shift
    printf "${color_green}==>${color_none}${color_bold} ${mesg}${color_none}\n" "$@" >&1
}

msg2() {
    local mesg=$1; shift
    printf "${color_blue} ->${color_none}${color_bold} ${mesg}${color_none}\n" "$@" >&1
}

warning() {
    local mesg=$1; shift
    printf "${color_yellow}==> WARNING:${color_none}${color_bold} ${mesg}${color_none}\n" "$@" >&2
}

error() {
    local mesg=$1; shift

    printf "${color_red}==> ERROR:${color_none}${color_bold} ${mesg}${color_none}\n" "$@" >&2
}
