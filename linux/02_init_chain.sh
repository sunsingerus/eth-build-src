#!/bin/bash

source ./00_config.sh

mkdir -p "${ETHER_DATA_DIR}"
cp ./genesis.json "${ETHER_DATA_DIR}"
"${GOPATH_DIR}"/bin/geth --datadir "${ETHER_DATA_DIR}" init "${ETHER_DATA_DIR}/genesis.json"

