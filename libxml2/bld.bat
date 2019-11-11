cd "%SRC_DIR%\win32"
cscript configure.js compiler=msvc "prefix=%LIBRARY_PREFIX%" ^
  "include=%LIBRARY_INC%" "lib=%LIBRARY_LIB%" ^
  "incdir=%LIBRARY_INC%" "libdir=%LIBRARY_LIB%" ^
  "sodir=%LIBRARY_BIN%" "bindir=%LIBRARY_BIN%" debug=no

nmake /f Makefile.msvc
nmake /f Makefile.msvc install
