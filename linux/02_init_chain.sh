#!/bin/bash

source ./00_config.sh

mkdir -p "${ETHDATA_DIR}"
cp ./genesis.json "${ETHDATA_DIR}"
"${GOPATH_DIR}"/bin/geth --datadir "${ETHDATA_DIR}" init "${ETHDATA_DIR}/genesis.json"

