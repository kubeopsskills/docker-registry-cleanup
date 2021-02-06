# Kubernetes Local Docker Registry Cleanup

This container can help you to clean up local Docker registry in any Kubernetes environments in case of out of image file system (imagefs) storage, but you don't prefer to modify Cloud virtual machine images.

## Supported tags and respective Dockerfile links

| Distribution | Version      | Tag          | Dockerfile |
|--------------|--------------|--------------|------------|
| Docker Registry Cleanup Alpine | latest, 0.0.1 | latest, 0.0.1 | [Dockerfile](https://github.com/kubeopsskills/docker-registry-cleanup/blob/master/Dockerfile) |

## Used in Kubernetes

When we run a container in Kubernetes, we can use the docker-registry-cleanup container to clean up local Docker registry. This can be done by kubectl command.

```sh
$ kubectl apply -f example/docker-registry-cleanup.yaml
```

## References

* [Docker Homepage](https://www.docker.com/)
* [Docker Userguide](https://docs.docker.com/get-started/overview/)