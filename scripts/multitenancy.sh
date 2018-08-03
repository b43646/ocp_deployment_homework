#!/usr/bin/sh

export GUID=`hostname | cut -d"." -f2`

# 1. Create Users/Group

ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd amy 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd andrew 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd brian 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd betty 123'

oc adm groups new alpha amy andrew
oc adm groups new beta brian betty

# 2. Config ResourceQuota For Users

for OCP_USERNAME in amy andrew brian betty; do

oc create clusterquota clusterquota-$OCP_USERNAME \
 --project-annotation-selector=openshift.io/requester=$OCP_USERNAME \
 --hard pods=25 \
 --hard requests.memory=6Gi \
 --hard requests.cpu=5 \
 --hard limits.cpu=25  \
 --hard limits.memory=40Gi \
 --hard configmaps=25 \
 --hard persistentvolumeclaims=25  \
 --hard services=25

done

# 3. Customize Project Template With LimitRange
oc create -f ./resources/template.yaml

ansible masters -m shell -a'systemctl stop atomic-openshift-master-api'
ansible masters -m shell -a'systemctl stop atomic-openshift-master-controllers'

ansible masters -m copy -a 'src=./scripts/custom_master.sh dest=~/custom_master.sh owner=root group=root mode=0744'
ansible masters -m shell -a './custom_master.sh'

ansible masters -m shell -a'systemctl start atomic-openshift-master-api'
ansible masters -m shell -a'systemctl start atomic-openshift-master-controllers'
