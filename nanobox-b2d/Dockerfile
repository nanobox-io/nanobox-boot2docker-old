FROM boot2docker/boot2docker

# Customize for Vagrant
RUN mkdir -p /rootfs/home/docker/.ssh
RUN chmod 0700 /rootfs/home/docker/.ssh
RUN chown -R 1000:50 /rootfs/home/docker/.ssh
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant-insecure-public-key" > /rootfs/home/docker/.ssh/authorized_keys
RUN chmod 0600 /rootfs/home/docker/.ssh/authorized_keys

# Include rsync
RUN cp /usr/bin/rsync /rootfs/usr/bin/rsync
RUN cp /lib/x86_64-linux-gnu/libattr.so.1 /rootfs/lib/libattr.so.1
RUN cp /lib/x86_64-linux-gnu/libacl.so.1 /rootfs/lib/libacl.so.1
RUN cp /lib/x86_64-linux-gnu/libpopt.so.0 /rootfs/lib/libpopt.so.0

# Install nanobox-server
RUN mkdir -p /rootfs/var/nanobox
# Just having the nanobox-server binary on the filesystem seems to cause a kernel panic on boot (linux hosts)
RUN echo "none" > /rootfs/var/nanobox/nanobox-server.md5
ADD files/services/. /rootfs/etc/init.d/services/
# [This](http://distro.ibiblio.org/tinycorelinux/corebook.pdf) is useful
ADD files/bootscript.sh /rootfs/opt/bootscript.sh

# rsync when available
RUN for dep in bash readline ncurses; do \
    echo "Download http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz" &&\
        curl -s -L -o /tmp/$dep.tcz http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz && \
        unsquashfs -f -d /rootfs /tmp/$dep.tcz && \
        rm -f /tmp/$dep.tcz ;\
    done

# Environment things
RUN echo "/bin/bash" >> /rootfs/etc/shells
ADD files/bashrc /rootfs/usr/local/etc/bashrc
ADD files/motd /rootfs/etc/motd
RUN sed -i "s/DATE/$(date)/g" /rootfs/etc/motd

# Manually rechown from tcz installs
RUN chown -R 1000:50 /rootfs/home/docker
RUN chown -R root:50 /rootfs/root/

# Custom passwd file
ADD files/passwd /rootfs/etc/passwd
RUN chown root:50 /rootfs/etc/passwd
RUN chmod 664 /rootfs/etc/passwd

# Custom shadow file
ADD files/shadow /rootfs/etc/shadow
RUN chown root:50 /rootfs/etc/shadow

# Custom sudoers file
ADD files/sudoers /rootfs/etc/sudoers
RUN chown root:root /rootfs/etc/sudoers
RUN chmod 440 /rootfs/etc/sudoers

RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
