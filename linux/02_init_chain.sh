#!/bin/bash

source ./00_config.sh

mkdir -p "${ETHER_DATA_DIR}"

cat <<EOF > "${ETHER_DATA_DIR}/genesis.json"
{
    "config": {
        "chainId": ${ETHER_NETWORK_ID},
        "homesteadBlock": 0,
        "eip155Block": 0,
        "eip158Block": 0
    },
    "difficulty": "1",
    "gasLimit": "2100000",
    "alloc": {
    }
}
EOF

"${GOPATH_DIR}/bin/geth" \
	--datadir "${ETHER_DATA_DIR}" \
	init "${ETHER_DATA_DIR}/genesis.json"

