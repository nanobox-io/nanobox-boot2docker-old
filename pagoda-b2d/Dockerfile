FROM boot2docker/boot2docker

# Customize for Vagrant
COPY vagrant  /rootfs/etc/rc.d/vagrant
RUN echo "/etc/rc.d/vagrant" >> /rootfs/opt/bootsync.sh
# Include rsync
RUN cp /usr/bin/rsync /rootfs/usr/bin/rsync
RUN cp /lib/x86_64-linux-gnu/libattr.so.1 /rootfs/lib/libattr.so.1
RUN cp /lib/x86_64-linux-gnu/libacl.so.1 /rootfs/lib/libacl.so.1
RUN cp /lib/x86_64-linux-gnu/libpopt.so.0 /rootfs/lib/libpopt.so.0

RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
