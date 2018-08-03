#!/usr/bin/sh

export GUID=`hostname | cut -d"." -f2`

# 1. Create Users/Group

ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd Amy 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd Andrew 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd Brian 123'
ansible master1.$GUID.internal -m shell -a 'htpasswd -cb /etc/origin/master/htpasswd Betty 123'

oc adm groups new alpha Amy Andrew
oc adm groups new beta Brian Betty

# 2. Config ResourceQuota For Users

for OCP_USERNAME in Amy Andrew Brian Betty; do

oc create clusterquota clusterquota-${OCP_USERNAME} \
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

