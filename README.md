# do-kubectl

This project containerizes the kubectl command along with useful utilities 
like kubectx, kubeps1, and kubetail to facilitate managing kubernetes clusters
from the command line without having to install these tools.


This is a Depend on Docker project which comes operational out of the box 
and is configured with reasonable defaults, which can be customized as needed.


The project contains the following scripts:
`config.sh` - open the configuration file .env in an editor so the project can be customized
`build.sh` - build the container image
`test.sh` - run container unit tests
`push.sh` - push the container image to a registry
`pull.sh` - pull the container image from a registry
`run.sh [cmd]` - run the container, passing an argument overrides the default command
`status.sh` - show container status - running, exited, etc.
`logs.sh` - tail container logs
`exec.sh [cmd]` - open a shell or execute a specified command in the running container

# Use

To start the container, execute:

```
docker run -it --rm -v ${HOME}/.kube:/etc/.kube iankoulski/do-kubectl bash
```

or clone the repo and execute

```
./run.sh bash
```

or

```
./run.sh
./exec.sh
```

As soon as the bash shell opens in the container, you can check the available aliases by running `alias`::

```
k - kubectl
kctl - kubectl
kn - kubens
kc - kubectx
kt - kubetail
koff - turn off kubernetes info from prompt
kon - turn on kubernetes info in prompt
```

You can execute commands against the kubernetes contexts configured in your ${HOME}/.kube folder.

```
kubectl get nodes

or

k get no
```

