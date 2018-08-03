#!/usr/bin/sh

PWD=`pwd`

# 1. update ansible hosts

rm -f /etc/ansible/hosts

cp $PWD/resources/hosts /etc/ansible/

export GUID=`hostname | cut -d"." -f2`

sed -i "s/27b0/$GUID/g" /etc/ansible/hosts

ansible localhost,all -m shell -a 'export GUID=`hostname | cut -d"." -f2`; echo "export GUID=$GUID" >> $HOME/.bashrc'

# 2. check configs

ansible all -m ping

ansible nodes -m shell -a"systemctl status docker | grep Active"

ansible nodes -m shell -a"docker version|grep Version"

yum repolist

ansible all -m shell -a"yum repolist"

ansible nfs -m shell -a"exportfs"

# yum -y install atomic-openshift-utils atomic-openshift-clients

# 3. deployment

ansible-playbook -f 20 /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml

ret=`echo $?`

if [ "$ret" != "0" ]; then
    echo "fail to check prerequisites"
    exit 1
fi

ansible-playbook -f 20 /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml

ret=`echo $?`

if [ "$ret" != "0" ]; then
    echo "fail to deploy cluster"
    exit 1
fi


# 4. post-install

ansible support1.$GUID.internal -m copy -a 'src=pv.sh dest=~/pv.sh mod=0744'

ansible support1.$GUID.internal -m shell -a './pv.sh'

ansible masters[0] -b -m fetch -a "src=/root/.kube/config dest=/root/.kube/config flat=yes"

chmod +x ./pvs.sh

./pvs

cat /root/pvs/* | oc create -f -

# check pv list
oc get pv

# Fix NFS Persistent Volume Recycling
ansible nodes -m shell -a "docker pull registry.access.redhat.com/openshift3/ose-recycler:latest"
ansible nodes -m shell -a "docker tag registry.access.redhat.com/openshift3/ose-recycler:latest registry.access.redhat.com/openshift3/ose-recycler:v3.9.30"

echo "Done!"