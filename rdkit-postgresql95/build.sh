$PYTHON "$RECIPE_DIR/pkg_version.py"

cd $SRC_DIR/Code/PgSQL/rdkit

cmake \
    -D CMAKE_SYSTEM_PREFIX_PATH=$PREFIX \
    -D CMAKE_INSTALL_PREFIX=$PREFIX \
    -D CMAKE_BUILD_TYPE=Release \
    -D RDK_OPTIMIZE_NATIVE=ON \
    -D RDK_BUILD_AVALON_SUPPORT=ON \
    -D RDK_BUILD_INCHI_SUPPORT=ON \
    -D RDK_BUILD_CPP_TESTS=OFF \
    -D RDK_BUILD_PYTHON_WRAPPERS=OFF \
    -D RDKit_DIR=$PREFIX/lib \
    .

make -j$CPU_COUNT

/bin/bash -e ./pgsql_install.sh


export PGPORT=54321
export PGDATA=$SRC_DIR/pgdata

pg_ctl initdb

# ensure that the rdkit extension is loaded at process startup
echo "shared_preload_libraries = 'rdkit'" >> $PGDATA/postgresql.conf

pg_ctl start -l $PGDATA/log.txt

# wait a few seconds just to make sure that the server has started
sleep 2

set +e
ctest
check_result=$?
set -e

pg_ctl stop

exit $check_result
