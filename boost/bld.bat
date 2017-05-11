if "%PY_VER%"=="2.7" ( 
	set BOOST_TOOLSET=msvc-9.0 
) else if  "%PY_VER%"=="3.4" ( 
	set BOOST_TOOLSET=msvc-10.0 
) else if  "%PY_VER%"=="3.5" ( 
	set BOOST_TOOLSET=msvc-14.0
) else if  "%PY_VER%"=="3.6" ( 
	set BOOST_TOOLSET=msvc-14.0
) else (
	echo "Unexpected version of python"
	exit 1
)

set BZIP2_INCLUDE=%PREFIX%\include
set BZIP2_LIBPATH=%PREFIX%\lib
set ZLIB_INCLUDE=%PREFIX%\include
set ZLIB_LIBPATH=%PREFIX%\lib

if "%PKG_VERSION%"=="1.56.0" ( 
	set BOOST_DIR=%SRC_DIR%\boost_1_56_0 
) else if  "%PKG_VERSION%"=="1.59.0" ( 
	set BOOST_DIR=%SRC_DIR%\boost_1_59_0
) else (
	echo "Unexpected version of boost"
	exit 1
) 

set STAGE_DIR="%BOOST_DIR%\stage"

chdir /d "%BOOST_DIR%"
call bootstrap.bat
if errorlevel 1 exit 1

b2.exe --build-type=complete -j %CPU_COUNT% --prefix=%STAGE_DIR% architecture=x86 address-model=%ARCH% toolset=%BOOST_TOOLSET% link=shared runtime-link=shared stage

xcopy "%BOOST_DIR%\boost" "%LIBRARY_INC%\boost" /s /e /i

rem xcopy %STAGE_DIR%\lib\libboost_*-mt-1_*.lib "%LIBRARY_LIB%"
xcopy %STAGE_DIR%\lib\boost_*-mt-1_*.lib "%LIBRARY_LIB%"
xcopy %STAGE_DIR%\lib\boost_*-mt-1_*.dll "%PREFIX%"

