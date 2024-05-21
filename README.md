# How to use this script and files

clone the repository then make symbolic links of the script and .mpssh folder to your home directory (or whatever folder,` really). The following is the help message:

```sh
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
```

# Host files format
edit the <code>.mpssh/*</code> hosts files to your heart desires.

The lines that start with '%' are the grouping/labels of the following lines of ssh machines to execute a command against.

note that these scripts use the <a href="https://github.com/ndenev/mpssh">mpssh</a> command
