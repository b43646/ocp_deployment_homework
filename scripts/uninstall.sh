#!/usr/bin/bash

ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/adhoc/uninstall.yml
ansible nodes -a "rm -rf /etc/origin"
ansible nfs -a "rm -rf /srv/nfs/*"