Download software:

7z archive
https://kent.dl.sourceforge.net/project/sevenzip/7-Zip/16.04/7z1604-x64.msi

Optional Far manager
https://farmanager.com/files/Far30b5254.x64.20180805.msi

Optional git
https://github.com/git-for-windows/git/releases/download/v2.18.0.windows.1/Git-2.18.0-64-bit.exe

MinGW compiler
https://netix.dl.sourceforge.net/project/mingw-w64/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/5.4.0/threads-posix/sjlj/x86_64-5.4.0-release-posix-sjlj-rt_v5-rev0.7z
Unpack and place mingw into c:\mingw64

Golang (version 1.10.3):
https://dl.google.com/go/go1.10.3.windows-amd64.msi
Install into c:\Go

Ethereum sources (version 1.8.10):
https://github.com/ethereum/go-ethereum/archive/v1.8.10.tar.gz

mkdir c:\godev\src\github.com\ethereum
move c:\godev\src\github.com\ethereum\go-ethereum-1.8.10 c:\godev\src\github.com\ethereum\go-ethereum

check geth available:
geth version

Geth
Version: 1.8.10-stable
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.10.3
Operating System: linux
GOPATH=/home/user/godev
GOROOT=/home/user/go
