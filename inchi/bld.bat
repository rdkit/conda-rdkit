copy "%RECIPE_DIR%\CMakeLists.txt" .

cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -D CMAKE_BUILD_TYPE=Release ^
    .

nmake
nmake install
