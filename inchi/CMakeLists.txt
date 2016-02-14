cmake_minimum_required(VERSION 3.0)

project(InChI)

include_directories(INCHI_API/inchi_dll)

set(INCHI_DLL_SOURCES
    INCHI_API/inchi_dll/ichican2.c
    INCHI_API/inchi_dll/ichicano.c
    INCHI_API/inchi_dll/ichicans.c
    INCHI_API/inchi_dll/ichiisot.c
    INCHI_API/inchi_dll/ichilnct.c
    INCHI_API/inchi_dll/ichimak2.c
    INCHI_API/inchi_dll/ichimake.c
    INCHI_API/inchi_dll/ichimap1.c
    INCHI_API/inchi_dll/ichimap2.c
    INCHI_API/inchi_dll/ichimap4.c
    INCHI_API/inchi_dll/ichinorm.c
    INCHI_API/inchi_dll/ichiparm.c
    INCHI_API/inchi_dll/ichiprt1.c
    INCHI_API/inchi_dll/ichiprt2.c
    INCHI_API/inchi_dll/ichiprt3.c
    INCHI_API/inchi_dll/ichiqueu.c
    INCHI_API/inchi_dll/ichiring.c
    INCHI_API/inchi_dll/ichisort.c
    INCHI_API/inchi_dll/ichister.c
    INCHI_API/inchi_dll/ichitaut.c
    INCHI_API/inchi_dll/ichi_bns.c
    INCHI_API/inchi_dll/inchi_dll.c
    INCHI_API/inchi_dll/ichiread.c
    INCHI_API/inchi_dll/ichirvr1.c
    INCHI_API/inchi_dll/ichirvr2.c
    INCHI_API/inchi_dll/ichirvr3.c
    INCHI_API/inchi_dll/ichirvr4.c
    INCHI_API/inchi_dll/ichirvr5.c
    INCHI_API/inchi_dll/ichirvr6.c
    INCHI_API/inchi_dll/ichirvr7.c
    INCHI_API/inchi_dll/inchi_dll_main.c
    INCHI_API/inchi_dll/runichi.c 
    INCHI_API/inchi_dll/inchi_dll_a.c
    INCHI_API/inchi_dll/inchi_dll_a2.c
    INCHI_API/inchi_dll/ikey_dll.c
    INCHI_API/inchi_dll/ikey_base26.c
    INCHI_API/inchi_dll/ichi_io.c
    INCHI_API/inchi_dll/sha2.c
    INCHI_API/inchi_dll/strutil.c
    INCHI_API/inchi_dll/util.c
    )

if (WIN32)
  add_library(inchi_dll STATIC ${INCHI_DLL_SOURCES})
		
  set_target_properties(inchi_dll
                        PROPERTIES
                        OUTPUT_NAME inchi
                        )

else (WIN32)
  add_library(inchi_dll SHARED ${INCHI_DLL_SOURCES})
		
  set_target_properties(inchi_dll
                        PROPERTIES
                        OUTPUT_NAME inchi
                        VERSION 1
                        SOVERSION 1.04.00
                        )
endif(WIN32)

install(TARGETS inchi_dll
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
	
install(FILES INCHI_API/inchi_dll/inchi_api.h
        DESTINATION ${CMAKE_INSTALL_PREFIX}/include/inchi)
