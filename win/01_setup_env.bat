mkdir c:\godev
mkdir c:\godev
mkdir c:\godev\bin
mkdir c:\godev\pkg
mkdir c:\godev\src

set "GOPATH=c:\godev"
setx GOPATH "%GOPATH%"

REM c:\go\bin - golang binaries
REM c:\godev\bin - ethereum binaries
REM c:\mingw64\bin - gcc compiler binaries
set "Path=c:\go\bin;c:\godev\bin;c:\mingw64\bin;%Path%"
setx Path "%Path%"
