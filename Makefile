build: boot2docker-nano.iso
	time packer build -parallel=false template.json

prepare: clean boot2docker-nano.iso

boot2docker-nano.iso:
	vagrant up && vagrant destroy --force

clean:
	rm -rf *.iso *.box
	vagrant destroy --force

.PHONY: clean prepare build
