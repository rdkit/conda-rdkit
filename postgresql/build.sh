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

make world
make check
make install-world

