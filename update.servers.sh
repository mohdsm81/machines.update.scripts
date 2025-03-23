#!/usr/bin/bash

usage(){
echo "
If you want to update all services, provide no arguments. Otherwise, you can
either update debian-based services by providing 'deb' or arch-based services by
providing 'arch' as argument.

USAGE:

update.servers.sh [-h | --help | deb | arch | reboot]

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
    mpssh -f $HOME/.mpssh/hosts -l deb 'apt update && apt upgrade -y'
}

update_arch(){
    mpssh -f $HOME/.mpssh/hosts -l arch 'yay -Syu --noconfirm'
}

reboot_services(){
    mpssh -f $HOME/.mpssh/services 'reboot'
}

clean_them(){
    mpssh -f $HOME/.mpssh/hosts -l deb 'apt clean -y';
    mpssh -f $HOME/.mpssh/hosts -l arch 'yay -Sccc --noconfirm';
}

get_opts_and_do(){

    # DEBUG
    # echo "num args: "
    # echo $1

    # echo "first arg: "
    # echo $2

    narg=$1
    arg=$2

    if [ $narg -gt 1 ]; then
        echo "provide at most one argument (-h, --help, deb, arch, or reboot) or
        call the scripts without arguments to update all servieces/servers."
        exit 1
    fi

    if [ $narg -eq 0 ]; then
        # update all machines if no arguments
        echo "
        ===========================
        | updating ALL servers   |
        ===========================
        "
        #
        update_deb
        update_arch
        exit 0
    fi


    case $arg in
        -h|--help)
            usage
        ;;
        clean)
            echo "
            ===========================
            | cleaning all hosts      |
            ===========================
            "
            clean_them
        ;;
        deb)
            echo "
            ===========================
            | updating DEB servers   |
            ===========================
            "
            update_deb
        ;;
        arch)
            echo "
            ===========================
            | updating ARCH servers   |
            ===========================
            "
            update_arch
        ;;
        reboot)
            echo "
            ===========================
            | rebooting all services  |
            ===========================
            "
            reboot_services
        ;;
        *)
            usage
        ;;
    esac

    exit 0
}

# passing number of args, and the first arg
get_opts_and_do "$#" "$1"
