APPNAME=ignite
USERNAME=wsuzume

IMAGE=${USERNAME}/docker-ansible:latest

SSH_DIR=~/.ssh
CONFIG_DIR=~/config

TRUE_INVENTORY=${CONFIG_DIR}/${APPNAME}
TRUE_ROOT_INVENTORY=${CONFIG_DIR}/${APPNAME}/root/inventory
TRUE_USER_INVENTORY=${CONFIG_DIR}/${APPNAME}/user/inventory
CONTAINER_ROOT_INVENTORY=/playbook/root/inventory
CONTAINER_USER_INVENTORY=/playbook/user/inventory


# build container image
.PHONY: image
image: Dockerfile
	docker image build -f ${SOURCE} -t ${IMAGE} .

.PHONY: pull
pull:
	docker pull ${IMAGE}

.PHONY: push
push:
	docker push ${IMAGE}

# clean up all stopped containers
.PHONY: clean
clean:
	docker container prune

# delete all image
.PHONY: doomsday
doomsday:
	docker image rm -f `docker image ls -q`


copy_inventory:
	./script/copy_inventory.sh ${TRUE_INVENTORY}

.SILENT:
true_inventory:
	echo ${TRUE_INVENTORY}

# create new container and login to the shell
.PHONY: shell
shell:
	docker container run -it --rm \
		-v ${PWD}/playbook:/playbook \
		-v ${SSH_DIR}:/tmp/.ssh \
		-v ${TRUE_ROOT_INVENTORY}:${CONTAINER_ROOT_INVENTORY} \
		-v ${TRUE_USER_INVENTORY}:${CONTAINER_USER_INVENTORY} \
		${IMAGE} bash -c "cp -r /tmp/.ssh ~/.ssh && bash"
