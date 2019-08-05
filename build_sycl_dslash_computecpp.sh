#!/bin/bash
#
source ./env_computecpp.sh

pushd ${BUILDDIR}

if [ -d ./build_sycl_dslash ]; 
then 
  rm -rf ./build_sycl_dslash
fi

mkdir  ./build_sycl_dslash
pushd ./build_sycl_dslash


cmake ${SRCDIR}/SyCLDslash \
	-G"Eclipse CDT4 - Unix Makefiles" \
	-DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/sycl_dslash \
	-DCMAKE_EXE_LINKER_FLAGS="${PK_LDFLAGS} ${PK_LIBS}" \
	-DCMAKE_CXX_COMPILER=${PK_CXX} \
	-DCMAKE_CXX_FLAGS="${PK_CXXFLAGS}" \
	-DQDPXX_DIR="${INSTALLDIR}/qdp++-scalar/share" \
	-DMG_FORTRANLIKE_COMPLEX=OFF \
	-DMG_DEBUG_INCLUDES=OFF \
	-DMG_USE_NEIGHBOR_TABLE=OFF \
	-DMG_USE_LAYOUT_LEFT=OFF \
        -DMG_USE_COMPUTE_CPP=ON \
	-DComputeCpp_DIR=$COMPUTECPP_HOME

${MAKE} VERBOSE=1

popd

popd
