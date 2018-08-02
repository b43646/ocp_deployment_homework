#!/usr/bin/env python
# coding=utf-8

import os
import sys


def install():
    os.system("scripts/install.sh")


def cicd():
    os.system("dir")


def multitenancy():
    pass


def uninstall():
    pass


def test():
    os.system("scripts/test.sh")



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
        'help': help
    }[param]()


if __name__ == '__main__':
    cmd(sys.argv[1])



