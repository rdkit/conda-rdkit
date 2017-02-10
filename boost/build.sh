#!/bin/bash

# Hints:
# http://boost.2283326.n4.nabble.com/how-to-build-boost-with-bzip2-in-non-standard-location-td2661155.html
# http://www.gentoo.org/proj/en/base/amd64/howtos/?part=1&chap=3

# Build dependencies:
# - bzip2-devel

echo "PREFIX: " $PREFIX
export CFLAGS="-m64 -pipe -O2 -march=x86-64 -fPIC -shared"
export CXXFLAGS="${CFLAGS}"

export BZIP2_INCLUDE="${PREFIX}/include"
export BZIP2_LIBPATH="${PREFIX}/lib"
export ZLIB_INCLUDE="${PREFIX}/include"
export ZLIB_LIBPATH="${PREFIX}/lib"

./bootstrap.sh --prefix="${PREFIX}/" --with-libraries=python,regex,thread,system;

sed -i'.bak' -e's/^using python.*;//' ./project-config.jam

PY_INC=`$PYTHON -c "from distutils import sysconfig; print (sysconfig.get_python_inc(0, '$PREFIX'))"`

echo "using python" >> ./project-config.jam
echo "     : $PY_VER" >> ./project-config.jam
echo "     : $PYTHON" >> ./project-config.jam
echo "     : $PY_INC" >> ./project-config.jam
echo "     : $PREFIX/lib" >> ./project-config.jam
echo "     ;" >> ./project-config.jam


# on the Mac, using py3 with at least conda 3.7.3 requires a symlink for the shared library:
if [ $OSX_ARCH == "x86_64" -a $PY3K == 1 ]; then
  tmpd=$PWD
  cd $PREFIX/lib
  ln -s libpython${PY_VER}m.dylib libpython${PY_VER}.dylib
  cd $tmpd
fi
./b2 -q install \
     --with-python --with-regex --with-serialization --with-thread --with-system \
     --debug-configuration include=$PY_INC;

