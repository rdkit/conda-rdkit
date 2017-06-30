%PYTHON% "%RECIPE_DIR%\pkg_version.py"

cd "%SRC_DIR%\Code\PgSQL\rdkit"

where jom 2> NUL
if %ERRORLEVEL% equ 0 (
    set MAKE_CMD=jom -j%CPU_COUNT%
) else (
    set MAKE_CMD=nmake
)

cmake ^
    -G "NMake Makefiles" ^
    -D CMAKE_SYSTEM_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIXX% ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D RDK_OPTIMIZE_NATIVE=ON ^
    -D RDK_BUILD_AVALON_SUPPORT=ON ^
    -D RDK_BUILD_INCHI_SUPPORT=ON ^
    -D RDKit_DIR=%LIBRARY_PREFIX%\lib ^
    .

%MAKE_CMD%

call pgsql_install.bat

set PGPORT=54321
set PGDATA=%SRC_DIR%\pgdata

pg_ctl initdb

rem ensure that the rdkit extension is loaded at process startup
echo shared_preload_libraries = 'rdkit' >> %PGDATA%\postgresql.conf

pg_ctl -D %PGDATA% -l %PGDATA%/log.txt start

rem wait a few seconds just to make sure that the server has started
timeout /t 2 /nobreak > NUL

ctest -V
set check_result=%ERRORLEVEL%

pg_ctl stop

exit /b %check_result%
