#!/bin/bash

source ./00_config.sh

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHDATA_DIR}" \
	--ethash.dagdir "${ETHDATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${NETWORK_ID}" \
	--exec "admin.nodeInfo.enode" \
	attach

