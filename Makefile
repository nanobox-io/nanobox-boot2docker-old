build: boot2docker-nano.iso
	time packer build -parallel=false template.json

prepare: clean boot2docker-nano.iso

boot2docker-nano.iso:
	[ -f boot2docker.iso ] || ( wget https://github.com/boot2docker/boot2docker/releases/download/v1.6.2/boot2docker.iso && \
	vagrant up && \
	vagrant destroy --force )

clean:
	rm -rf *.iso *.box
	vagrant destroy --force

.PHONY: clean prepare build
