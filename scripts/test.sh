#!/usr/bin/bash

oc new-project smoke-test
oc new-app nodejs-mongo-persistent

export GUID=`hostname|awk -F. '{print $2}'`

sleep 100

curl http://nodejs-mongo-persistent-smoke-test.apps.$GUID.example.opentlc.com | grep "Welcome to your Node.js application on OpenShift"

ret=`echo $?`

if [ "$ret" != "0" ]; then
    echo "[Test]......................................FAIL"
    exit 1
fi
echo "[Test]......................................PASS"