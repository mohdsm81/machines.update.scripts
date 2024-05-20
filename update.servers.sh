#!/usr/bin/bash

usage(){
echo "
If you want to update all services, provide no arguments. Otherwise, you can
either update debian-based services by providing 'deb' or arch-based services by
providing 'arch' as argument.

USAGE:

update.servers.sh [-h | --help] | [deb | arch | reboot]

EXAMPLES:

# to show help
update.servers.sh --help
# or
update.servers.sh -h

# to update debian based services
update.servers.sh deb

# and for arch-based servers
update.servers.sh arch

# to update all services/servers, call it w/o arguments
update.servers.sh

# to reboot services
update.servers.sh reboot
"
}

update_deb(){
    mpssh -f .mpssh/hosts -l deb 'apt update && apt upgrade -y'
}

update_arch(){
    mpssh -f .mpssh/hosts -l arch 'yay -Syu --noconfirm'
}

get_opts_and_do(){

    if [ $# -gt 1 ]; then
        echo "provide at most one argument (-h, --help, deb, arch, or reboot) or
        call the scripts without arguments to update all servieces/servers."
        exit
    fi;

    if [ $# -eq 0 ]; then
        # update all machines if no arguments
        update_deb
        update_arch
        exit
    fi;

    arg=#1
    case $arg in
        -h|--help)
            usage
            break
        ;;
        deb)
            update_deb
            break
        ;;
        arch)
            update_arch
            break
        ;;
        reboot)
            /usr/bin/reboot
            break
        ;;
    esac;

    exit
}

get_opts_and_do
