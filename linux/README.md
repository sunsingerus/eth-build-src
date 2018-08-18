mkdir -p /home/user/ethdatadir

echo "{
    \"config\": {
        \"chainId\": 15,
        \"homesteadBlock\": 0,
        \"eip155Block\": 0,
        \"eip158Block\": 0
    },
    \"difficulty\": \"1\",
    \"gasLimit\": \"2100000\",
    \"alloc\": {
    }
}" > /home/user/ethdatadir/genesis.json

geth --datadir /home/user/ethdatadir init /home/user/ethdatadir/genesis.json


bootnode --genkey=/home/user/ethdatadir/boot.key
bootnode --nodekey=/home/user/ethdatadir/boot.key --verbosity 15

enode://1450690e73974a87e5a45cfd201d8c8cec6a52aaa319c3bc2094711bb7bd6e84778c9148d70a9f4bd4b2a9be45ac2939e0b8f3a05ca1a0fb9a2599320f6b283d@[192.168.74.149]:30301

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 6 \
	--networkid 15 \
	--bootnodes enode://1450690e73974a87e5a45cfd201d8c8cec6a52aaa319c3bc2094711bb7bd6e84778c9148d70a9f4bd4b2a9be45ac2939e0b8f3a05ca1a0fb9a2599320f6b283d@[192.168.74.149]:30301

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 6 \
	--networkid 15 \
	--bootnodes enode://1450690e73974a87e5a45cfd201d8c8cec6a52aaa319c3bc2094711bb7bd6e84778c9148d70a9f4bd4b2a9be45ac2939e0b8f3a05ca1a0fb9a2599320f6b283d@[192.168.74.149]:30301
	--mine \
	--minerthreads=1 \
	--etherbase=0x0d9256493ddafa413f239ec969d584028a539983

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 6 \
	--networkid 15 \
	attach

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 6 \
	--networkid 15 \
	account list

geth \
	--datadir /home/user/ethdatadir \
	--ethash.dagdir /home/user/ethdatadir/ethash \
	--verbosity 6 \
	--networkid 15 \
	account new

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

https://ethereum.stackexchange.com/questions/28703/full-list-of-geth-terminal-commands
https://medium.com/cybermiles/running-a-quick-ethereum-private-network-for-experimentation-and-testing-6b1c23605bce


================
Windows
geth --datadir c:\ethdatadir init c:\ethdatadir\genesis.json

geth \
	--datadir c:\ethdatadir \
	--ethash.dagdir c:\ethdatadir\ethash \
	--verbosity 6 \
	--networkid 15 \
	--bootnodes enode://1450690e73974a87e5a45cfd201d8c8cec6a52aaa319c3bc2094711bb7bd6e84778c9148d70a9f4bd4b2a9be45ac2939e0b8f3a05ca1a0fb9a2599320f6b283d@[192.168.74.149]:30301

geth --datadir c:\ethdatadir \
	--verbosity 6 \
	--networkid 15 \
	attach


