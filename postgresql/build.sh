#!/bin/sh

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

make
make check
make install

pushd contrib
make
make check
make install
popd

