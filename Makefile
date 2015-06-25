VERSION=$(shell cat ./version)

build: nanobox-boot2docker.iso
	time packer build -parallel=false template.json

prepare: clean nanobox-boot2docker.iso

nanobox-boot2docker.iso:
	vagrant up && vagrant destroy --force

re-box:
	rm -rf *.iso *.box
	vagrant box remove "`pwd`/nanobox-boot2docker.box" -f
	vagrant ssh -c 'docker rmi nanobox-boot2docker' && vagrant provision && packer build -parallel=false template.json

clean:
	rm -rf *.iso *.box
	vagrant destroy --force
	vagrant box remove "`pwd`/nanobox-boot2docker.box" -f

release:
	vim version
	git tag -a $(VERSION) -m $(VERSION)
	git push --tags

.PHONY: clean prepare build
