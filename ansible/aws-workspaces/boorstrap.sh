#!/bin/bash
mkdir /var/log/trak/
chmod 755 /var/log/trak/
sudo amazon-linux-extras install ansible2 -y
sudo yum install git -y
echo "export GIT_PASS=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" >> /tmp/env-var.sh
echo "export FRONT_HOST=AAAAAAAAAAAA" >> /tmp/env-var.sh
source /tmp/env-var.sh
git clone https://github.com/icasadosar/prueba01 /tmp/ansible_playbooks
ansible-playbook /tmp/ansible_playbooks/ansible/aws-workspaces/workspaces-django.yml