#!/bin/bash

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 3 \
	attach

