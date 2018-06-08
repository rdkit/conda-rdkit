if %VS_MAJOR%==9 (
  set VS_SLN_DIR=9
) else if %VS_MAJOR%==11 (
  set VS_SLN_DIR=11
) else if %VS_MAJOR% GEQ 14 (
  set VS_SLN_DIR=14
)

set BUILD_TYPE=Release

cd "%SRC_DIR%\MSVC%VS_SLN_DIR%"
MSBuild /t:libintl_dll /p:Configuration=%BUILD_TYPE%
if %ARCH%==32 (
    set ARCH_DIR=Win32
) else if %ARCH%==64 (
    set ARCH_DIR=x64
)

xcopy "libintl_dll\%ARCH_DIR%\%BUILD_TYPE%\libintl.lib" "%LIBRARY_LIB%"
xcopy "libintl_dll\%ARCH_DIR%\%BUILD_TYPE%\libintl.dll" "%LIBRARY_BIN%"
