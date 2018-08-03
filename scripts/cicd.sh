#!/usr/bin/sh

PWD=`pwd`

ansible-playbook -i $PWD/resources/container-pipelines/inventory/ $PWD/resources/openshift-applier/playbooks/openshift-cluster-seed.yml
