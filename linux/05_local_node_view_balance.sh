#!/bin/bash

source ./00_config.sh

"${GOPATH_DIR}/bin/geth" \
	--datadir "${ETHER_DATA_DIR}" \
	--ethash.dagdir "${ETHER_DATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${ETHER_NETWORK_ID}" \
	--exec 'web3.fromWei(eth.getBalance(eth.coinbase), "ether")' \
	attach

