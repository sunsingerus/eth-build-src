#!/bin/bash

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 3 \
	--bootnodes enode://a335e49a47d7ec0dc2d64136291fe1bd65318452c90858dd89027affae2b4c297e14f43d4593ca4140f0bd24bb24f46739c41a6b4f5720f3f3c4a48337293f33@[192.168.74.149]:30303

