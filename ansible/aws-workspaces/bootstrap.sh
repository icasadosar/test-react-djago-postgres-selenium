#!/bin/bash
echo "%$(id -g) ALL=(ALL) NOPASSWD:ALL" > /tmp/sudo-tmp
sudo bash -c 'cat /tmp/sudo-tmp > /etc/sudoers.d/01-ws-admin-user'
#sudo visudo -cf /etc/sudoers.d/01-ws-admin-user
mkdir /var/log/trak/
chmod 755 /var/log/trak/
sudo amazon-linux-extras install ansible2 -y
sudo yum update
sudo yum install yum-utils -y
sudo yum install git -y
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform
source /tmp/env-var.sh
git clone https://github.com/icasadosar/prueba01 /tmp/ansible_playbooks
ansible-playbook /tmp/ansible_playbooks/ansible/nginx.yml
ansible-playbook /tmp/ansible_playbooks/ansible/nodejs.yml
ansible-playbook /tmp/ansible_playbooks/ansible/django.yml
ansible-playbook /tmp/ansible_playbooks/ansible/postgresql.yml 





