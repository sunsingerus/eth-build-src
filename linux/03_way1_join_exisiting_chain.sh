#!/bin/bash

source ./00_config.sh

# --bootnodes is an address reported by a node duriong start procedure
# Ex.:
# self=enode://47667e59f7c9947af6246985b7dd8eb54410da92edb64d395a9ec7acd5665bf92ce0535f07618dc7dff4037b9f8a0000fbeaae7469465241ee367908229bff9c@[::]:30303
# Also this enode can be extracted with 04_local_node_view_enode.sh
# But, those enodes has "::" as an IP address. which is correct for localhost only
# It is more correct to specify IP in this address
# Ex.:
# enode://47667e59f7c9947af6246985b7dd8eb54410da92edb64d395a9ec7acd5665bf92ce0535f07618dc7dff4037b9f8a0000fbeaae7469465241ee367908229bff9c@[192.168.74.149]:30303
BOOTNODE="enode://47667e59f7c9947af6246985b7dd8eb54410da92edb64d395a9ec7acd5665bf92ce0535f07618dc7dff4037b9f8a0000fbeaae7469465241ee367908229bff9c@[192.168.74.149]:30303"

"${GOPATH_DIR}"/bin/geth \
	--datadir "${ETHER_DATA_DIR}" \
	--ethash.dagdir "${ETHER_DATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${ETHER_NETWORK_ID}" \
	--bootnodes "${BOOTNODE}"

