#!/bin/bash

source ./00_config.sh

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHER_DATA_DIR}" \
	--ethash.dagdir "${ETHER_DATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${ETHER_NETWORK_ID}" \
	account new

# As a result of this command would be
# Address: {acd70592d536334753a6a9cdbdfcd7e682935850}
