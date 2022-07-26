#!/bin/bash

# Mounting NFS volumes
sudo yum update -y
sudo mkdir -p /data/test
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ echo/data/test
echo "${efs_dns_name}:/  /data/test nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 0 0" |sudo tee -a /etc/fstab