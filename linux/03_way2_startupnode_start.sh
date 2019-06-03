#!/bin/bash

source ./00_config.sh

# Use address reported on previous step as:
# Your new account is locked with a password. Please give a password. Do not forget this password.
# Passphrase:
# Repeat passphrase:
# Address: {acd70592d536334753a6a9cdbdfcd7e682935850}
ETHER_ADDRESS="0xacd70592d536334753a6a9cdbdfcd7e682935850"

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHDATA_DIR}" \
	--ethash.dagdir "${ETHDATA_DIR}"/ethash \
	--verbosity 3 \
	--mine \
	--minerthreads=1 \
	--etherbase="${ETHER_ADDRESS}"

