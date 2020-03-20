export CFLAGS="-I$PREFIX/include -L$PREFIX/lib $CFLAGS"
if [ $(uname) == Linux ]; then
    XWIN_ARGS="--enable-xcb-shm"
fi
if [ $(uname -m) == x86_64 ]; then
    export ax_cv_c_float_words_bigendian="no"
fi
find $PREFIX -name '*.la' -delete
./configure \
    --enable-xlib=no \
    --enable-xlib-xrender=no \
    --enable-xcb=no \
    --disable-static \
    --disable-gtk-doc \
    --prefix=$PREFIX

make && make install && rm -rf $PREFIX/share
