FROM ubuntu:20.04

# installing tzdata stops if this environment variable not defined
ENV DEBIAN_FRONTEND=noninteractive

# sshpass is needed for ansible first login to remote server
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        vim curl git python3 python3-pip sshpass \
    && apt-get clean

RUN apt update \
    && apt-get install -y software-properties-common \
    && add-apt-repository --yes --update ppa:ansible/ansible \
    && apt-get install -y ansible

ARG UID=1000
RUN useradd -m -u ${UID} josh
USER josh

WORKDIR /playbook

# -------------

# install ansible
#RUN pip3 install ansible
