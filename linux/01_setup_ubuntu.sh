#!/bin/bash

# Setup paths
ROOT_DIR=~
GOLANG_VERSION="1.10.3"
GOPATH_DIR="${ROOT_DIR}/gocode"
GOROOT_DIR="${ROOT_DIR}/go"
ETH_VERSION="1.8.10"

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
cd $ROOT_DIR

banner "Install prerequisites:"
next
sudo apt install git wget

banner "Install gcc (tested with gcc 5.4)"
next
sudo apt install gcc

banner "Check gcc is available"
next
echo "Result: ==========="
gcc --version

banner "Download golang distro (version ${GOLANG_VERSION}):"
next
wget https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz

banner "Unpack golang:"
next
tar -xvf go${GOLANG_VERSION}.linux-amd64.tar.gz

banner "Setup GOPATH env - create dir structure ${GOPATH_DIR}"
next
mkdir -p ${GOPATH_DIR}/{bin,pkg,src}

banner "Add ${GOPATH_DIR} path as \$GOPATH env"
next
echo "export GOPATH=\"${GOPATH_DIR}\"" >> ~/.bashrc
echo "Result: ==========="
tail -n5 ~/.bashrc

banner "Add ${GOROOT_DIR}/bin path to \$PATH env"
next
echo "export PATH=\"${GOROOT_DIR}/bin:${GOPATH_DIR}/bin:\$PATH\"" >> ~/.bashrc
echo "Result: ==========="
tail -n5 ~/.bashrc

banner "Apply session ENV vars"
next
export GOPATH="${GOPATH_DIR}"
export PATH="${GOROOT_DIR}/bin:${GOPATH_DIR}/bin:$PATH"

banner "Cd into ${ROOT_DIR}"
next
cd $ROOT_DIR

banner "verify \$GOPATH available"
next
echo "Result: ==========="
echo $GOPATH

banner "Ensure 'go' command is available"
echo "Expected result: 'go version go${GOLANG_VERSION} linux/amd64'"
next
echo "Result: ==========="
go version

banner "Download Ethereum sources (version ${ETH_VERSION})"
next
wget https://github.com/ethereum/go-ethereum/archive/v${ETH_VERSION}.tar.gz

banner "Prepare sources dir structure"
next
mkdir -p "${GOPATH_DIR}/src/github.com/ethereum"

banner "Unpack into sources dir"
next
tar -xvf v${ETH_VERSION}.tar.gz -C "${GOPATH_DIR}/src/github.com/ethereum"
echo "And rename sources folder - it should be named as go-ethereum"
mv "${GOPATH_DIR}/src/github.com/ethereum/go-ethereum-${ETH_VERSION}" "${GOPATH_DIR}/src/github.com/ethereum/go-ethereum"

banner "Build & install"
next
cd "${GOPATH_DIR}/src/github.com/ethereum/go-ethereum"
go install -v ./cmd/...

banner "Check geth available"
echo "expected result:
Geth
Version: ${ETH_VERSION}-stable
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go${GOLANG_VERSION}
Operating System: linux
GOPATH=${GOPATH_DIR}
GOROOT=${GOROOT_DIR}
"
next
echo "Result: ==========="
geth version

banner "Restart user session now - exit and login back"

