.PHONY: root
root:
	ansible-playbook -i root/inventory/server root/playbook.yml

.PHONY: user
user:
	ansible-playbook -i user/inventory/server user/playbook.yml \
		-u sirius --private-key="~/.ssh/id_common"
