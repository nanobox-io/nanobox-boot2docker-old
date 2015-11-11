#!/bin/sh -x

# Configure sysctl
/etc/rc.d/sysctl

# Load TCE extensions
/etc/rc.d/tce-loader

# Automount a hard drive
/etc/rc.d/automount

# Trigger the DHCP request sooner (the x64 bit userspace appears to be a second slower)
echo "$(date) dhcp -------------------------------"
/etc/rc.d/dhcp.sh
echo "$(date) dhcp -------------------------------"

# Mount cgroups hierarchy
/etc/rc.d/cgroupfs-mount
# see https://github.com/tianon/cgroupfs-mount

mkdir -p /var/lib/boot2docker/log

# Add any custom certificate chains for secure private registries
/etc/rc.d/install-ca-certs

# import settings from profile (or unset them)
test -f "/var/lib/boot2docker/profile" && . "/var/lib/boot2docker/profile"

# set the hostname
/etc/rc.d/hostname

# sync the clock
/etc/rc.d/ntpd &

# start cron
/etc/rc.d/crond

if ! grep -q '^docker:' /etc/group; then
    # if we have the docker user, let's create the docker group
    /bin/addgroup -S docker
    # ... and add our docker user to it!
    /bin/addgroup docker docker
fi

# chown home dir properly 
chown -R docker:staff /home/docker

# Automount Shared Folders (VirtualBox, etc.)
/etc/rc.d/automount-shares

# Configure SSHD
/etc/rc.d/sshd

# Launch ACPId
/etc/rc.d/acpid

echo "-------------------"
date
#maybe the links will be up by now - trouble is, on some setups, they may never happen, so we can't just wait until they are
sleep 5
date
ip a
echo "-------------------"

# Allow local bootsync.sh customisation
if [ -e /var/lib/boot2docker/bootsync.sh ]; then
    /bin/sh -x /var/lib/boot2docker/bootsync.sh
    echo "------------------- ran /var/lib/boot2docker/bootsync.sh"
fi

# Launch Docker
/etc/rc.d/docker

# Allow local HD customisation
if [ -e /var/lib/boot2docker/bootlocal.sh ]; then
    /bin/sh -x /var/lib/boot2docker/bootlocal.sh > /var/log/bootlocal.log 2>&1 &
    echo "------------------- ran /var/lib/boot2docker/bootlocal.sh"
fi

# Execute automated_script
/etc/rc.d/automated_script.sh

# Run Hyper-V KVP Daemon
if modprobe hv_utils &> /dev/null; then
    /usr/sbin/hv_kvp_daemon
fi

# Temporary patch to vboxsf
if modprobe vboxsf &> /dev/null; then
    modprobe -a vboxsf
fi

# Start nfs client
/usr/local/etc/init.d/nfs-client start

# Launch vmware-tools
/etc/rc.d/vmtoolsd

# Start nanobox-server
/etc/init.d/services/nanoboxd start
