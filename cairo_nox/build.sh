source activate root
export CFLAGS="-I$PREFIX/include -L$PREFIX/lib $CFLAGS"

./configure \
    --enable-xlib=no \
    --enable-xlib-xrender=no \
    --enable-xcb=no \
    --disable-static \
    --disable-gtk-doc \
    --prefix=$PREFIX

make && make install && rm -rf $PREFIX/share
