#!/usr/bin/sh

oc autoscale dc/spring-rest --min=1 --max=10 --cpu-percent=80 -n basic-spring-boot-prod