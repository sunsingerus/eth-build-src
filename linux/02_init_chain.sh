#!/bin/bash

mkdir -p /home/user/ethdatadir
cp genesis.json /home/user/ethdatadir
geth --datadir /home/user/ethdatadir init /home/user/ethdatadir/genesis.json

