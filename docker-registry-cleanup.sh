#!/bin/bash

# Remove exited containers
docker ps -a -q -f status=exited    | xargs --no-run-if-empty docker rm -v
# Remove unused images
docker image prune -a -f
# Remove dangling volumes
docker volume ls -qf dangling=true  | xargs --no-run-if-empty docker volume rm