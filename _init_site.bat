@echo off

rem --------------------------------------------------------
rem delete site files
rem --------------------------------------------------------
del *.pem
del *.csr
del *.key
del *.crt
del .rnd

rem --------------------------------------------------------
rem initialize demoCA folder
rem --------------------------------------------------------
call  rm_folder demoCA
mkdir demoCA
mkdir demoCA\newcerts
mkdir demoCA\private
copy  root\root.key demoCA\private\cakey.pem
copy  root\root.crt demoCA\cacert.pem

rem --------------------------------------------------------
rem make default files
rem --------------------------------------------------------
touch .\demoCA\index.txt
echo 01 > .\demoCA\serial

rem --------------------------------------------------------
rem epilogue
rem --------------------------------------------------------
goto eof

rem --------------------------------------------------------
rem rm_folder
rem --------------------------------------------------------
:rm_folder
  set __path__=%1
  if not defined __path__ goto :eof
  for /f "tokens=*" %%I in ('dir /b /s /ad %__path__%*') do if %%~nxI==%__path__% (
    rmdir /s /q "%%I"
  )
goto eof

:eof