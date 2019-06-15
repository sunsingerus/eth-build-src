#!/bin/bash

source ./00_config.sh

PASSWORD=111

# Account creator is expected to be quiet
OUT=$("${GOPATH_DIR}/bin/geth" \
	--datadir "${ETHER_DATA_DIR}" \
	--ethash.dagdir "${ETHER_DATA_DIR}"/ethash \
	--verbosity "0" \
	--networkid "${ETHER_NETWORK_ID}" \
	--password=<(echo "${PASSWORD}") \
	account new)
# As a result of this command would be
# Address: {acd70592d536334753a6a9cdbdfcd7e682935850}
LINE=$(echo ${OUT} | tail -n1)
ETHER_ADDRESS=$(echo ${LINE}  | awk '{print $2}' | sed 's/[{,}]//g')
echo ${ETHER_ADDRESS} | tee ./ether_address

