#!/bin/bash

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 3 \
	--mine \
	--minerthreads=1 \
	--etherbase=0xNNNNNNNNNNNNNNNNNNNNN

