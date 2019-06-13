
#
# Setup components version
#

#GOLANG_VERSION="1.10.3"
#GOLANG_VERSION="1.12.5"
GOLANG_VERSION="1.11.10"
#ETHER_VERSION="1.8.10"
#ETHER_VERSION="1.8.27"
ETHER_VERSION="1.8.26"

#
# Setup paths
#
ROOT_DIR=~

# Go paths
GOPATH_DIR="${ROOT_DIR}/gocode"
GOROOT_DIR="${ROOT_DIR}/go"

# Ethereum and Swarm paths
ETHER_DATA_DIR=~/ethereum_data
SWARM_DATA_DIR="${ETHER_DATA_DIR}"

#
# Ethereum options
#

# Each private network has to have unique ID
ETHER_NETWORK_ID=15
SWARM_NETWORK_ID=15

# Ethereum compoments verbosity
VERBOSITY=3

