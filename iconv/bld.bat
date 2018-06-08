if %VS_MAJOR%==9 (
  set VS_SLN_DIR=9
) else if %VS_MAJOR%==11 (
  set VS_SLN_DIR=11
) else if %VS_MAJOR%==14 (
  set VS_SLN_DIR=14
) else if %VS_MAJOR% GEQ 15 (
  set VS_SLN_DIR=15
)

set BUILD_TYPE=Release

cd "%SRC_DIR%\MSVC%VS_SLN_DIR%"
MSBuild /t:libiconv_dll /p:Configuration=%BUILD_TYPE%
if %ARCH%==32 (
    set ARCH_DIR=Win32
) else if %ARCH%==64 (
    set ARCH_DIR=x64
)

xcopy "%ARCH_DIR%\%BUILD_TYPE%\libiconv.lib" "%LIBRARY_LIB%"
xcopy "libiconv_dll\%ARCH_DIR%\%BUILD_TYPE%\libiconv.dll" "%LIBRARY_BIN%"
xcopy "%SRC_DIR%\source\include\iconv.h" "%LIBRARY_INC%"
