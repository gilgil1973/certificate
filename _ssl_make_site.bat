@echo off

rem --------------------------------------------------------
rem usage   : _ssl_make_site <common name>
rem example : _ssl_make_site test.com
rem --------------------------------------------------------
set BASE_FILE_NAME=%1
set COMMON_NAME=%1

rem --------------------------------------------------------
rem make key file(test.com.key)
rem --------------------------------------------------------
openssl genrsa -out %BASE_FILE_NAME%.key 1024

rem --------------------------------------------------------
rem make csr file(test.com.csr)
rem --------------------------------------------------------
openssl req -new -subj "/C=KR/CN=%COMMON_NAME%" -key %BASE_FILE_NAME%.key -out %BASE_FILE_NAME%.csr
 
rem --------------------------------------------------------
rem make crt file(test.com.crt)
rem --------------------------------------------------------
openssl ca -batch -startdate 20140301000000Z -enddate 20240227000000Z -policy policy_anything -out %BASE_FILE_NAME%.crt -infiles %BASE_FILE_NAME%.csr

rem --------------------------------------------------------
rem make key crt file(test.com.pem)
rem --------------------------------------------------------
copy %BASE_FILE_NAME%.key + %BASE_FILE_NAME%.crt %BASE_FILE_NAME%.pem
rem del  %BASE_FILE_NAME%.key
rem del  %BASE_FILE_NAME%.csr
rem del  %BASE_FILE_NAME%.crt
