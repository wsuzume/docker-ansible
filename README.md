# docker-ansible
This is Ansible client docker image with SSH & UFW setting automation example.

# Usage

```
$ git clone git@github.com:wsuzume/docker-ansible
$ cd docker-ansible

# copy inventory to your ~/config/[appname]
$ make copy_inventory

# build image
$ make image

# or pull image
$ make pull
```

And then, `$ make shell` enables you to enter to the new container.
In the container, you can use `ansible` commands, `make` command, and some other commands.
Enjoy your Ansible life.

## SSH & UFW setting automation example
Before you proceed to the next steps, you should generate keys for user `admin` and `sirius`.
Each key name should be `~/.ssh/id_admin` and `~/.ssh/id_common`, or you have to change example codes.

```
$ ssh-keygen -t ed25519
```

And then, you can make SSH & UFW settings automatically by following commands in the container.

```
$ make root
$ make user
```

`$ make user` is just "Hello world" for just checking connection. You can edit `user/playbook.yml` for your own purpose.
