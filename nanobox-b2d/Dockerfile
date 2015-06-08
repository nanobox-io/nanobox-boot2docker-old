FROM boot2docker/boot2docker

# Customize for Vagrant
ADD vagrant  /rootfs/etc/rc.d/vagrant
RUN echo "/etc/rc.d/vagrant" >> /rootfs/opt/bootsync.sh

# Include rsync
RUN cp /usr/bin/rsync /rootfs/usr/bin/rsync
RUN cp /lib/x86_64-linux-gnu/libattr.so.1 /rootfs/lib/libattr.so.1
RUN cp /lib/x86_64-linux-gnu/libacl.so.1 /rootfs/lib/libacl.so.1
RUN cp /lib/x86_64-linux-gnu/libpopt.so.0 /rootfs/lib/libpopt.so.0

# rsync when available
RUN for dep in bash readline ncurses; do \
    echo "Download http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz" &&\
        curl -L -o /tmp/$dep.tcz http://tinycorelinux.net/6.x/x86_64/tcz/$dep.tcz && \
        unsquashfs -f -d /rootfs /tmp/$dep.tcz && \
        rm -f /tmp/$dep.tcz ;\
    done

RUN echo "/bin/bash" >> /rootfs/etc/shells

ADD bashrc /rootfs/usr/local/etc/bashrc

ADD passwd /rootfs/etc/passwd
RUN chown root:staff /rootfs/etc/passwd
ADD shadow /rootfs/etc/shadow
RUN chown root:staff /rootfs/etc/shadow
ADD sudoers /rootfs/etc/sudoers
RUN chown root:root /rootfs/etc/sudoers

RUN chmod 664 /rootfs/etc/passwd
RUN chown root:staff /rootfs/etc/passwd

RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
