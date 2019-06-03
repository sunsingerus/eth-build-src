#!/bin/bash

source ./00_config.sh

# Use address reported on previous step as:
# Your new account is locked with a password. Please give a password. Do not forget this password.
# Passphrase:
# Repeat passphrase:
# Address: {acd70592d536334753a6a9cdbdfcd7e682935850}
ETHER_ADDRESS="0x0dd3e3b80ddbe034845e3aacc7a880836b2b3045"

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHDATA_DIR}" \
	--ethash.dagdir "${ETHDATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${NETWORK_ID}" \
	--mine \
	--minerthreads=1 \
	--etherbase="${ETHER_ADDRESS}"

