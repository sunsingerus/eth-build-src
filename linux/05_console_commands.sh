#!/bin/bash

cat <<EOF
Interesting console commands would be:

net.listening
net.peerCount 
eth.blockNumber
eth.getBalance(eth.coinbase).toNumber();
eth.gasPrice
eth.getCoinbase
eth.protocolVersion
admin.peers
admin.addPeer(enodeUrlOfFirstInstance).
admin.nodeInfo
admin.datadir
eth.mining
miner.start(1)
miner.stop()
EOF


