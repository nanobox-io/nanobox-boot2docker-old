# boot2docker nanobox Vagrant Box

This repository contains the scripts necessary to create a Vagrant-compatible
[boot2docker](https://github.com/steeve/boot2docker) box for [nanobox](http://nanobox.io).

## Usage

Import the box with `vagrant box add nanobox/boot2docker`

## Building the Box

In order to have [atlas](https://atlas.hashicorp.com/nanobox/boxes/boot2docker) build the box, you'll first need to create 
the boot2docker iso. This is [simplified](https://github.com/nanobox-io/nanobox-boot2docker/blob/8074806e4cbe735e5d446832a71fbbad048f0256/nanobox-b2d/Dockerfile#L65) 
by the [nanobox/boot2docker](https://hub.docker.com/r/nanobox/boot2docker)
image.  
  
To build the box, first install the following prerequisites:

  * [Packer](http://www.packer.io) (at least version 0.8)  
**AND**
    * [VirtualBox](http://www.virtualbox.org) (at least version 5.0), VMware, or Parallels
    * [Vagrant](http://www.vagrantup.com) (at least version 1.7)  
**OR**
    * [Docker](https://www.docker.com/) (at least version)

Then follow the steps:

```
# pull and run nanobox/boot2docker, creating the iso
$ vagrant up
...
# (optional) remove vagrant box
$ vagrant destroy --force
...
# push the iso and repo to atlas for building
$ packer push template.json
...
```
**OR**
```
# pull nanobox/boot2docker
$ docker pull nanobox/boot2docker

# run nanobox/boot2docker, creating the iso
$ docker run nanobox/boot2docker > nanobox-boot2docker.iso

# push the iso and repo to atlas for building
$ packer push template.json
```

Note: To use the newly created box, you may need to remove any old boxes from vagrant.   
Find with `vagrant box list` and remove with `vagrant box remove $NAME`

### License

Mozilla Public License, version 2.0