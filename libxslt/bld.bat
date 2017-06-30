cd "%SRC_DIR%\win32"
cscript configure.js compiler=msvc "prefix=%LIBRARY_PREFIX%" ^
  "include=%LIBRARY_INC%;%LIBRARY_INC%\libxml2" "lib=%LIBRARY_LIB%" ^
  "incdir=%LIBRARY_INC%" "libdir=%LIBRARY_LIB%" ^
  "sodir=%LIBRARY_BIN%" "bindir=%LIBRARY_BIN%" debug=no ^
  static=no modules=yes crypto=yes vcmanifest=yes ^
  iconv=yes

nmake /f Makefile.msvc
nmake /f Makefile.msvc install
