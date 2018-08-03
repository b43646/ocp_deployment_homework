### ocp_deployment_homework

###### 1. Overview

The repo provide a tool to meet the requirements of homework.

```
[root@bastion ~]# git clone https://github.com/b43646/ocp_deployment_homework.git

[root@bastion ~]# cd ocp_deployment_homework/
[root@bastion ocp_deployment_homework]# python cli.py help

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
```

###### 2. Deploy The Cluster

```

python cli.py install

```

###### 3. Test The Cluster

> wait 100s

```

python cli.py test

```

###### 4. Deploy CICD Demo

```

python cli.py cicd

```

###### 5. Enable HPA

```

python cli.py hpa

```


###### 6. Config Multitenancy

```

python cli.py multitenancy

```

###### 7. Uninstall

```

python cli.py uninstall

```