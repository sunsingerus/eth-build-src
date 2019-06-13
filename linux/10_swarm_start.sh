#!/bin/bash

source ./00_config.sh

# o start Swarm you need an Ethereum account. You can create a new account in `geth`
${GOPATH_DIR}/bin/geth \
	--datadir "${ETHER_DATA_DIR}" \
	account new

# Return like:
# Address: {39f3a6c1de996f4ca247872d6ea296d16a5d77ea}

# Run `swarm` with connect to exsting netqorks
#$ swarm --bzzaccount <your-account-here>
#${GOPATH_DIR}/bin/swarm --bzzaccount 2f1cd699b0bf461dcfbf0098ad8f5587b038f0f1
${GOPATH_DIR}/bin/swarm --bzzaccount "${ACCOUNT}"
# When running, swarm is accessible through an HTTP API on port 8500

# https://swarm-guide.readthedocs.io/en/latest/up-and-download.html

#If you don’t want your swarm node to connect to any existing networks, 
#you can provide it with a custom network identifier using --bzznetworkid with a random large number.

${GOPATH_DIR}/bin/swarm \
	--bzzaccount "${ACCOUNT}" \
	--datadir "${SWARM_DATA_DIR}" \
	--bzznetworkid "${SWARM_NETWORK_ID}"

#By default, swarm will automatically seek out peers in the network. This can be suppressed using the --nodiscover flag:
# DOES NOW WORK!!!!
#${GOPATH_DIR}/bin/swarm \
#	--bzzaccount "${ACCOUNT}" \
#	--datadir "${SWARM_DATA_DIR}" \
#	--ens-api "${SWARM_DATA_DIR}/geth.ipc" \
#	--bzznetworkid "${SWARM_NETWORK_ID}"
#	--nodiscover

# In separate shell we can connect to swarm with `geth` console.
# Swarm is fully compatible with Geth Console commands
${GOPATH_DIR}/bin/geth attach "${SWARM_DATA_DIR}/bzzd.ipc"

#Without discovery, it is possible to manually start off the connection process by adding one or more peers using the admin.addPeer console command.
#geth --exec='admin.addPeer("ENODE")' attach $HOME/.ethereum/bzzd.ipc
# Where ENODE is the enode record of a swarm node. Such a record looks like the following:
# enode://01f7728a1ba53fc263bcfbc2acacc07f08358657070e17536b2845d98d1741ec2af00718c79827dfdbecf5cfcd77965824421508cc9095f378eb2b2156eb79fa@1.2.3.4:30399

#
# Communite via HTTP
#

# To upload some data:
HASH=$(curl -H "Content-Type: text/plain" --data "some-data" http://localhost:8500/bzz:/); echo $HASH

# Download
curl "http://localhost:8500/bzz:/${HASH}/"

#
# Complex dir structure upload with Manifest
#

# create two directories with a file in each
mkdir dir1 dir2
echo "some-data" > dir1/file.txt
echo "some-data" > dir2/file.txt

# create a tar archive containing the two directories (this will tar everything in the working directory)
tar cf files.tar .

#upload the tar archive to Swarm to create a manifest
curl -H "Content-Type: application/x-tar" --data-binary @files.tar http://localhost:8500/bzz:/

# 1e0e21894d731271e50ea2cecf60801fdc8d0b23ae33b9e808e5789346e3355e

curl http://localhost:8500/bzz:/1e0e21894d731271e50ea2cecf60801fdc8d0b23ae33b9e808e5789346e3355e/dir1/file.txt
# some-data

curl -s -H "Accept: application/x-tar" http://localhost:8500/bzz:/ccef599d1a13bed9989e424011aed2c023fce25917864cd7de38a761567410b8/ | tar t
# dir1/file.txt
# dir2/file.txt

sudo apt install jq

# LIST files
curl -s http://localhost:8500/bzz-list:/ccef599d1a13bed9989e424011aed2c023fce25917864cd7de38a761567410b8/ | jq .
# {
#   "common_prefixes": [
#     "dir1/",
#     "dir2/",
#     "dir3/"
#   ]
# }

curl -s http://localhost:8500/bzz-list:/ccef599d1a13bed9989e424011aed2c023fce25917864cd7de38a761567410b8/dir1/ | jq .
# {
#  "entries": [
#    {
#      "path": "dir1/file.txt",
#      "contentType": "text/plain",
#      "size": 9,
#      "mod_time": "2017-03-12T15:19:55.112597383Z",
#      "hash": "94f78a45c7897957809544aa6d68aa7ad35df695713895953b885aca274bd955"
#    }
#  ]
# }

#
# Communicate via CLI
#

HASH=$("${GOPATH_DIR}/bin/swarm" up README.md)
# d1f25a870a7bb7e5d526a7623338e4e9b8399e76df8b634020d11d969594f24a

${GOPATH_DIR}/bin/swarm down "bzz:/${HASH}"            #downloads the file at <hash> to the current working directory
${GOPATH_DIR}/bin/swarm down "bzz:/${HASH}" file.tmp   #downloads the file at <hash> as ``file.tmp`` in the current working dir
${GOPATH_DIR}/bin/swarm down "bzz:/${HASH}" dir1/      #downloads the file at <hash> to ``dir1/``

#You can also specify a custom proxy with –bzzapi:
${GOPATH_DIR}/bin/swarm --bzzapi "http://localhost:8500" down "bzz:/${HASH}"            #downloads the file at <hash> to the current working directory using the localhost node

${GOPATH_DIR}/bin/swarm ls "${HASH}"

#Uploading directories is achieved with the --recursive flag.
HASH=$("${GOPATH_DIR}/bin/swarm" --recursive up ~/eth-build-src)
# ab90f84c912915c2a300a94ec5bef6fc0747d1fbaf86d769b3eed1c836733a30
#The returned hash refers to a root manifest referencing all the files in the directory.

# FUSE
# When using FUSE from the CLI, we assume you are running a local Swarm node on your machine. 
# The FUSE commands attach to the running node through bzzd.ipc
sudo apt-get install fuse
sudo modprobe fuse
#sudo chown user:user /etc/fuse.conf
#sudo chown user:user /dev/fuse


# To mount a Swarm resource, first upload some content to Swarm using the `swarm up <resource>` command. 
# You can also upload a complete folder using `swarm --recursive up <directory>`. 
# Once you get the returned manifest hash, use it to mount the manifest to a mount point (the mount point should exist on your hard drive):
# swarm fs mount <manifest-hash> <mount-point>

MOUNTPOINT=~/fusemountpoint
HASH="0a232e1a239f495b8ecec73d1bc15269060bdd9e593f1f82fc87c0fb6780096b"
mkdir -p "${MOUNTPOINT}"
${GOPATH_DIR}/bin/swarm \
        --datadir "${SWARM_DATA_DIR}" \
	fs mount "${HASH}" "${MOUNTPOINT}"

# $ swarm fs mount <manifest-hash> /home/user/swarmmount

# To unmount a swarmfs mount, either use the List Mounts command below, or use a known mount point:
${GOPATH_DIR}/bin/swarm \
        --datadir "${SWARM_DATA_DIR}" \
	fs unmount "${MOUNTPOINT}"

# IMPORTANT!
# The returned hash is the latest manifest version that was mounted.
# You can use this hash to remount the latest version with the most recent changes.

# To see all existing swarmfs mount points, use the List Mounts command:
${GOPATH_DIR}/bin/swarm \
        --datadir "${SWARM_DATA_DIR}" \
	fs list

