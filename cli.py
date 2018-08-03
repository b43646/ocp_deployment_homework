#!/usr/bin/env python
# coding=utf-8

import os
import sys


def install():
    os.system("chmod +x scripts/install.sh")
    os.system("scripts/install.sh")


def cicd():
    os.system("chmod +x scripts/cicd.sh")
    os.system("scripts/cicd.sh")


def multitenancy():
    os.system("chmod +x scripts/multitenancy.sh")
    os.system("scripts/multitenancy.sh")


def uninstall():
    os.system("chmod +x scripts/uninstall.sh")
    os.system("scripts/uninstall.sh")


def test():
    os.system("chmod +x scripts/test.sh")
    os.system("scripts/test.sh")


def hpa():
    os.system("chmod +x scripts/hpa.sh")
    os.system("scripts/hpa.sh")


def help():
    print '''
Usage:	Deployment Command

A simple tool to quickly deploy cluster in a similar environment.

Example:

python cli.py install|cicd|uninstall|multitenancy

Commands:
    install  -- install cluster
    test     -- deploy a simple app to verify that the cluster works well
    cicd     -- deploy cicd demo
    hpa      -- hpa for basic-spring-boot-prod
    multitenancy -- config multi tenancy
    uninstall    -- uninstall the cluster
    '''


def cmd(param):
    return {
        'install': install,
        'cicd': cicd,
        'multitenancy': multitenancy,
        'uninstall': uninstall,
        'test': test,
        'hpa': hpa,
        'help': help
    }[param]()


if __name__ == '__main__':
    cmd(sys.argv[1])



