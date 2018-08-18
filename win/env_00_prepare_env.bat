mkdir c:\dev
mkdir c:\dev\go
mkdir c:\dev\go\bin
mkdir c:\dev\go\pkg
mkdir c:\dev\go\src

set "GOPATH=c:\dev\go"
setx GOPATH "%GOPATH%"

;"Path=%GOPATH%\bin;%Path%"
; setx Path "%Path%"