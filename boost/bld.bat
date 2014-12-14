set BOOSTDIR=%SRC_DIR%\boost

"%SRC_DIR%\boost_1_56_0-msvc-10.0-%ARCH%.exe" /SILENT /DIR="%BOOSTDIR%"

xcopy "%BOOSTDIR%\boost" "%LIBRARY_INC%\boost" /s /e /i

xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-10.0\*vc100-mt-1_56.lib "%LIBRARY_LIB%"
xcopy "%BOOSTDIR%"\lib%ARCH%-msvc-10.0\*vc100-mt-1_56.dll "%PREFIX%"

