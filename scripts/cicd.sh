#!/usr/bin/sh

ansible-playbook -i ../resources/container-pipelines/inventory/ ../resources/openshift-applier/playbooks/openshift-cluster-seed.yml
