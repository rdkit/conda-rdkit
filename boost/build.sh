#!/bin/bash

# Hints:
# http://boost.2283326.n4.nabble.com/how-to-build-boost-with-bzip2-in-non-standard-location-td2661155.html
# http://www.gentoo.org/proj/en/base/amd64/howtos/?part=1&chap=3

# Build dependencies:
# - bzip2-devel

#Can't work out how to get patches to be applied by conda, hack around for now

echo "Applying patches"
cd $SRC_DIR/boost/atomic/detail
patch < $RECIPE_DIR/e4bde20f.patch
patch < $RECIPE_DIR/6bb71fdd.patch
echo "Patches applied"
cd $SRC_DIR

export CFLAGS="-m64 -pipe -O2 -march=x86-64 -fPIC -shared"
export CXXFLAGS="${CFLAGS}"

./bootstrap.sh --prefix="${PREFIX}/";

sed -i'.bak' -e's/^using python.*;//' ./project-config.jam

PY_INC=`$PYTHON -c "from distutils import sysconfig; print (sysconfig.get_python_inc(0, '$PREFIX'))"`

echo "using python" >> ./project-config.jam
echo "     : $PY_VER" >> ./project-config.jam
echo "     : $PYTHON" >> ./project-config.jam
echo "     : $PY_INC" >> ./project-config.jam
echo "     : $PREFIX/lib" >> ./project-config.jam
echo "     ;" >> ./project-config.jam

./b2 -q install --debug-configuration;

