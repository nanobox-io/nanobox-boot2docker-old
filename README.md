# boot2docker nanobox Vagrant Box

This repository contains the scripts necessary to create a Vagrant-compatible
[boot2docker](https://github.com/steeve/boot2docker) box for [nanobox](http://nanobox.io).

## Usage

If you want the actual box file, you can download it from the
[releases page](https://github.com/pagodabox/nanobox-boot2docker/releases).

## Building the Box

If you want to recreate the box, rather than using the binary, then
you can use the scripts and Packer template within this repository to
do so in seconds.

To build the box, first install the following prerequisites:

  * [Packer](http://www.packer.io) (at least version 0.5.1)
  * [VirtualBox](http://www.virtualbox.org) (at least version 4.3), VMware, or Parallels
  * [Vagrant](http://www.vagrantup.com)

Then follow the steps:

```
$ vagrant up
...
$ vagrant destroy --force
...
$ packer build template.json
...
```
   
Note: To use the newly created box, you may need to remove any old boxes from vagrant.   
Find with `vagrant box list` and remove with `vagrant box remove $NAME`

### License

Mozilla Public License, version 2.0