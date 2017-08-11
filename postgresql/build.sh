#!/bin/sh

# this is required to get the build to work on OS X
if [ "$OSX_ARCH" == "x86_64" ]; then
  export LDFLAGS="$LDFLAGS -Wl,-rpath,$PREFIX/lib"
  install_name_tool -id "@rpath/libreadline.6.2.dylib" $PREFIX/lib/libreadline.6.2.dylib
fi
./configure \
    --prefix=$PREFIX       \
    --with-includes=$PREFIX/include \
    --with-libraries=$PREFIX/lib \
    --enable-thread-safety \
    --with-readline        \
    --with-python          \
    --with-openssl         \
    --with-libxml          \
    --with-libxslt

make -j$CPU_COUNT
make check
make install

pushd contrib
make -j$CPU_COUNT
# make check may fail because of unix socket names
# being too long depending on the length of the path
# where anaconda is installed
# add an --ignore-errors if this is the case
make check
make install
popd

