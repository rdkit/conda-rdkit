%PYTHON% "%RECIPE_DIR%\pkg_version.py"

cd "%SRC_DIR%"

rmdir /s /q build 2> NUL
mkdir build
cd build
:: in case there are any old psql builds: remove them
rmdir /s /q Code\PgSQL 2> NUL

cmake ^
    -G "NMake Makefiles" ^
    -D RDK_BUILD_PGSQL=ON ^
    -D RDK_PGSQL_STATIC=ON ^
    -D RDK_INSTALL_INTREE=OFF ^
    -D RDK_INSTALL_STATIC_LIBS=OFF ^
    -D RDK_INSTALL_DEV_COMPONENT=OFF ^
    -D RDK_BUILD_INCHI_SUPPORT=ON ^
    -D RDK_BUILD_AVALON_SUPPORT=ON ^
    -D RDK_BUILD_FREESASA_SUPPORT=OFF ^
    -D RDK_USE_FLEXBISON=OFF ^
    -D RDK_BUILD_THREADSAFE_SSS=ON ^
    -D RDK_TEST_MULTITHREADED=ON ^
    -D RDK_OPTIMIZE_NATIVE=ON ^
    -D RDK_BUILD_CPP_TESTS=OFF ^
    -D RDK_BUILD_PYTHON_WRAPPERS=OFF ^
    -D RDK_USE_BOOST_SERIALIZATION=OFF ^
    -D CMAKE_SYSTEM_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -D CMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -D BOOST_ROOT=%PREFIX% -D Boost_NO_SYSTEM_PATHS=ON ^
    -D CMAKE_BUILD_TYPE=Release ^
    ..

where jom 2> NUL
if %ERRORLEVEL% equ 0 (
    set MAKE_CMD=jom -j%CPU_COUNT%
) else (
    set MAKE_CMD=nmake
)

%MAKE_CMD%

cd Code\PgSQL\rdkit
call pgsql_install.bat

set PGPORT=54321
set PGDATA=%SRC_DIR%\pgdata

pg_ctl initdb

rem ensure that the rdkit extension is loaded at process startup
echo shared_preload_libraries = 'rdkit' >> %PGDATA%\postgresql.conf

pg_ctl -D %PGDATA% -l %PGDATA%/log.txt start

rem wait a few seconds just to make sure that the server has started
ping -n 5 127.0.0.1 > NUL

set "RDBASE=%SRC_DIR%"
ctest -V
set check_result=%ERRORLEVEL%

pg_ctl stop

exit /b %check_result%
