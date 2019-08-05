. /usr/share/modules/init/bash
module load cmake-3.13.4

TOPDIR=`pwd`

BUILDDIR=${TOPDIR}/build
INSTALLDIR=${TOPDIR}/install
SRCDIR=${TOPDIR}/src

PK_CXX=g++
PK_CXXFLAGS="-O3 -march=native"

PK_CC=gcc
PK_CFLAGS="-O3 -march=native"
PK_OMP_ENABLE=""
MAKE="make -j 8"


