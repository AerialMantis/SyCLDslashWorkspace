. /usr/share/modules/init/bash
module load clang-9-intel-sycl
module load cmake-3.13.4
TOPDIR=`pwd`

BUILDDIR=${TOPDIR}/build
INSTALLDIR=${TOPDIR}/install
SRCDIR=${TOPDIR}/src

OPENCL_SDK=/opt/intel/system_studio_2019/opencl/SDK
export PATH=${OPENCL_SDK}/bin:$PATH
export LD_LIBRARY_PATH=${OPENCL_SDK}/lib64:$LD_LIBRARY_PATH

PK_CXX=clang++
PK_CXXFLAGS=" -fsycl -O3 -fopenmp"
PK_CC=clang
PK_CFLAGS="-O3 -fopenmp"
PK_LDFLAGS="-L${OPENCL_SDK}"
PK_LIBS="-lOpenCL -lsycl"

PK_OMP_ENABLE="--enable-openmp"
MAKE="make -j 8"


