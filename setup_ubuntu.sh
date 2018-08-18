#!/bin/bash

USER_HOME_DIR="/home/user"

##
## Display banner
##
function banner()
{
    # all params as one string
    local str="${*}"

    # str len in chars (not bytes)
    local char_len=${#str}

    # header has '## ' on the left and ' ##' on the right thus 6 chars longer that the str
    local head_len=$((char_len+6))

    # build line of required length '###########################'
    local head=""
    for i in $(seq 1 ${head_len}); do
        head="${head}#"
    done

    # build banner
    local res="${head}
## ${str} ##
${head}"

    # display banner
    echo "$res"
}

##
## Wait for user to press a key
##
function next()
{
    read -p "Press enter to continue"
}


banner "Let's start"
next
cd $USER_HOME_DIR

banner "Install prerequisites:"
next
sudo apt install git wget

banner "Install gcc (tested with gcc 5.4)"
next
sudo apt install gcc

banner "Check gcc is available"
next
gcc --version

banner "Download golang distro (version 1.10.3):"
next
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz

banner "Unpack golang:"
next
tar -zxvf go1.10.3.linux-amd64.tar.gz

banner "Setup GOPATH env - create dor structure $USER_HOME_DIR/godev"
next
mkdir -p $USER_HOME_DIR/godev/{bin,pkg,src}

banner "Add $USER_HOME_DIR/godev path as \$GOPATH env"
next
echo "export GOPATH=\"$USER_HOME_DIR/godev\"" >> $USER_HOME_DIR/.bashrc
echo "Result: ==========="
tail -n5 $USER_HOME_DIR/.bashrc

banner "Add $USER_HOME_DIR/go/bin path to \$PATH env"
next
echo "export PATH=\"$USER_HOME_DIR/go/bin:/home/user/godev/bin:\$PATH\"" >> $USER_HOME_DIR/.bashrc
echo "Result: ==========="
tail -n5 $USER_HOME_DIR/.bashrc

banner "Apply session ENV vars"
next
source $USER_HOME_DIR/.bashrc

banner "Cd into $USER_HOME_DIR"
next
cd $USER_HOME_DIR

banner "verify \$GOPATH available"
next
echo $GOPATH

banner "Ensure 'go' command is available"
echo "Expected result: 'go version go1.10.3 linux/amd64'"
next
go version

banner "Download Ethereum sources (version 1.8.10)"
next
wget https://github.com/ethereum/go-ethereum/archive/v1.8.10.tar.gz

banner "Prepare sources dir structure"
next
mkdir -p /home/user/godev/src/github.com/ethereum

banner "Unpack into sources dir"
next
tar -xf v1.8.10.tar.gz -C $USER_HOME_DIR/godev/src/github.com/ethereum
echo "And rename sources folder - it should be named as go-ethereum"
mv $USER_HOME_DIR/godev/src/github.com/ethereum/go-ethereum-1.8.10 $USER_HOME_DIR/godev/src/github.com/ethereum/go-ethereum

banner "Build & install"
next
cd $USER_HOME_DIR/godev/src/github.com/ethereum/go-ethereum
go install -v ./cmd/...

banner "Check geth available"
echo "expected result:
Geth
Version: 1.8.10-stable
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.10.3
Operating System: linux
GOPATH=$USER_HOME_DIR/godev
GOROOT=$USER_HOME_DIR/go
"
next
geth version

banner "Restart user session now"

