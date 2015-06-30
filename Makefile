VERSION=$(shell cat ./version)
ID=$(shell curl -s https://api.github.com/repos/pagodabox/nanobox-boot2docker/releases | json 0.id | tr -d '\n')
TOKEN=$(shell read -r -p "Enter Token: " token; echo $$token)

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

upload:
	@curl -H "Authorization: token $(TOKEN)" \
		-H "Accept: application/vnd.github.manifold-preview" \
		-H "Content-Type: application/octet-stream" \
		--data-binary @nanobox-boot2docker.box \
		"https://uploads.github.com/repos/pagodabox/nanobox-boot2docker/releases/$(ID)/assets?name=nanobox-boot2docker.box"

.PHONY: prepare build
