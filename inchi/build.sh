cp $RECIPE_DIR/CMakeLists.txt .

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX .

make install

