set BOOSTDIR=%SRC_DIR%\boost

"%SRC_DIR%\boost_1_55_0-msvc-10.0-%ARCH%.exe" /SILENT /DIR="%BOOSTDIR%"

xcopy "%BOOSTDIR%\boost" "%LIBRARY_INC%\boost" /s /e /i

xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-10.0\*.lib "%LIBRARY_LIB%"
xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-10.0\*.dll "%PREFIX%"

