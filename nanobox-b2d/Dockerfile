FROM boot2docker/boot2docker

# Customize for Vagrant
ADD files/vagrant  /rootfs/etc/rc.d/vagrant
RUN echo "/etc/rc.d/vagrant" >> /rootfs/opt/bootsync.sh

# Include rsync
RUN cp /usr/bin/rsync /rootfs/usr/bin/rsync
RUN cp /lib/x86_64-linux-gnu/libattr.so.1 /rootfs/lib/libattr.so.1
RUN cp /lib/x86_64-linux-gnu/libacl.so.1 /rootfs/lib/libacl.so.1
RUN cp /lib/x86_64-linux-gnu/libpopt.so.0 /rootfs/lib/libpopt.so.0

# Install nanobox-server
ADD files/nanobox-server /rootfs/usr/local/bin/nanobox-server
ADD files/services/. /rootfs/etc/init.d/services/
RUN echo "/etc/init.d/services/nanoboxd start" >> /rootfs/opt/bootlocal.sh
# This is where services that need to run on boot need to get put,
# [this](http://distro.ibiblio.org/tinycorelinux/corebook.pdf) is useful, but
# boot2docker has a customized tinycore
RUN echo "/etc/rc.d/nanoboxd" >> /rootfs/opt/bootscript.sh
ADD files/nanoboxd /rootfs/etc/rc.d/nanoboxd

# rsync when available
RUN for dep in bash readline ncurses; do \
    echo "Download http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz" &&\
        curl -L -o /tmp/$dep.tcz http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz && \
        unsquashfs -f -d /rootfs /tmp/$dep.tcz && \
        rm -f /tmp/$dep.tcz ;\
    done

RUN echo "/bin/bash" >> /rootfs/etc/shells

ADD files/bashrc /rootfs/usr/local/etc/bashrc
# ADD files/bashrc /rootfs/root/.bashrc
# ADD files/bashrc /rootfs/home/docker/.bashrc
ADD files/motd /rootfs/etc/motd
RUN sed -i "s/DATE/$(date)/g" /rootfs/etc/motd

ADD files/passwd /rootfs/etc/passwd
RUN chown root:staff /rootfs/etc/passwd
ADD files/shadow /rootfs/etc/shadow
RUN chown root:staff /rootfs/etc/shadow
ADD files/sudoers /rootfs/etc/sudoers
RUN chown root:root /rootfs/etc/sudoers
RUN chmod 440 /rootfs/etc/sudoers

RUN chmod 664 /rootfs/etc/passwd
RUN chown root:staff /rootfs/etc/passwd

RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
