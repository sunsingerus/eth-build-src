#!/bin/bash

source ./00_config.sh

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
	--ens-api "${SWARM_DATA_DIR}/geth.ipc" \
	--bzznetworkid "${SWARM_NETWORK_ID}"

#By default, swarm will automatically seek out peers in the network. This can be suppressed using the --nodiscover flag:
${GOPATH_DIR}/bin/swarm \
	--bzzaccount "${ACCOUNT}" \
	--datadir "${SWARM_DATA_DIR}" \
	--ens-api "${SWARM_DATA_DIR}/geth.ipc" \
	--bzznetworkid "${SWARM_NETWORK_ID}"
	--nodiscover

#Without discovery, it is possible to manually start off the connection process by adding one or more peers using the admin.addPeer console command.
#geth --exec='admin.addPeer("ENODE")' attach $HOME/.ethereum/bzzd.ipc
# Where ENODE is the enode record of a swarm node. Such a record looks like the following:
# enode://01f7728a1ba53fc263bcfbc2acacc07f08358657070e17536b2845d98d1741ec2af00718c79827dfdbecf5cfcd77965824421508cc9095f378eb2b2156eb79fa@1.2.3.4:30399

#
# Communite via HTTP
#

# To upload some data:
curl -H "Content-Type: text/plain" --data "some-data" http://localhost:8500/bzz:/

# Download
#curl http://localhost:8500/bzz:/027e57bcbae76c4b6a1c5ce589be41232498f1af86e1b1a2fc2bdffd740e9b39/

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

${GOPATH_DIR}/bin/swarm up example.md
# d1f25a870a7bb7e5d526a7623338e4e9b8399e76df8b634020d11d969594f24a

${GOPATH_DIR}/bin/swarm down bzz:/<hash>            #downloads the file at <hash> to the current working directory
${GOPATH_DIR}/bin/swarm down bzz:/<hash> file.tmp   #downloads the file at <hash> as ``file.tmp`` in the current working dir
${GOPATH_DIR}/bin/swarm down bzz:/<hash> dir1/      #downloads the file at <hash> to ``dir1/``

#You can also specify a custom proxy with –bzzapi:
${GOPATH_DIR}/bin/swarm --bzzapi http://localhost:8500 down bzz:/<hash>            #downloads the file at <hash> to the current working directory using the localhost node


#Uploading directories is achieved with the --recursive flag.
${GOPATH_DIR}/bin/swarm --recursive up /path/to/directory
# ab90f84c912915c2a300a94ec5bef6fc0747d1fbaf86d769b3eed1c836733a30
#The returned hash refers to a root manifest referencing all the files in the directory.

