#!/bin/bash

source ./00_config.sh

# Use address reported on previous step as:
# Your new account is locked with a password. Please give a password. Do not forget this password.
# Passphrase:
# Repeat passphrase:
# Address: {acd70592d536334753a6a9cdbdfcd7e682935850}
#ETHER_ADDRESS="0x0dd3e3b80ddbe034845e3aacc7a880836b2b3045"
#ETHER_ADDRESS="f8adba1f59e170f410fe43f75f97d2e943c774a5"

ETHER_ADDRESS=${ETHER_ADDRESS:-$(cat ./ether_address)}

if [[ -z ${ETHER_ADDRESS} ]]; then
	echo "Specify ether address, pelase. Can not continue"
	exit 1
fi

echo "Starting with address: ${ETHER_ADDRESS}"

${GOPATH_DIR}/bin/geth \
	--datadir "${ETHER_DATA_DIR}" \
	--ethash.dagdir "${ETHER_DATA_DIR}"/ethash \
	--verbosity "${VERBOSITY}" \
	--networkid "${ETHER_NETWORK_ID}" \
	--mine \
	--minerthreads=1 \
	--etherbase="${ETHER_ADDRESS}"

