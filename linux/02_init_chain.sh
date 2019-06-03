#!/bin/bash

ETHDATADIR=~/ethdatadir

mkdir -p "${ETHDATADIR}"
cp ./genesis.json "${ETHDATADIR}"
geth --datadir "${ETHDATADIR}" init "${ETHDATADIR}/genesis.json"

