#!/bin/bash

source ./00_config.sh

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHDATA_DIR}" \
	--ethash.dagdir "${ETHDATA_DIR}"/ethash \
	--verbosity 3 \
	account new
