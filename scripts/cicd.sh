#!/usr/bin/sh

PWD=`pwd`

ansible-playbook -i $PWD/resources/container-pipelines/applier/inventory/ $PWD/resources/openshift-applier/playbooks/openshift-cluster-seed.yml
