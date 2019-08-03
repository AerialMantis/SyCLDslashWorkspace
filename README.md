SyCLWilsonDslash MiniApp Workspace
=====================================

This git repository contains the SyCLDslash
package and its dependencies

- `SyCLDslash` depends on `googletest` and `qdp++`
- `qdp++` in turn depends on other USQCD libraries as
submodules, and `libxml2`.

Since libxml2 has developed a lot we include an older source
tree of libxml2 with this workspace that is known to compile
with our scripts. Users may wish to use an installed libxml2
on most systems one needs to install the developer package
(e.g. `libxml2-dev`) containing static libraries,

Checking out this repository
============================

It is highly recommended that this library be checked out using
the `--recursive` option to Git so that both `SyCLDslash` and
`qdp++` (aka `qdpxx`) check out their required submodules

Directory Layout
================
In the workspace are 3 main directories: `build`, `install` and
`src`:

* `src` contains the sources for `SyCLDslash`, QDP++ (`qdpxx`) and
 dependencies. WARNING: `SyCLDslash` and `qdpxx` are Git Submodules,
meaning they are checked out in what git calls `detached` mode. If you 
want to develop and commit etc, you should go into e.g. `SyCLDslash`
and check out an actual branch (e.g. `master` for `SyCLDslash` or 
`devel` for QDP++)


* `build` is the location for the out of source builds of `SyCLDslash`
and its dependencies

* `install` is where QDP++ and dependencies are installed. Note `SyCLDslash`
is not installed at this time, so the tests need to be run from the
`build` directory. 

Building the Mini Apps
======================

This is a single node mini-app which requires in essence just a 
SyCL/C++ compiler in addition to the sources. A straighforward build
involves:

a) setting up the `env.sh` file with compiler specifics. Typically
we keep separate env.sh files for various machines e.g. `env_qcdexadev19.sh`
and then symbolic link `env.sh` to these. 

b) editing the `build_xxx.sh` scripts 

The `build_all.sh` script will call in sequence the necessary
builds for `libxml2`, followed by `qdpxx` followed by the mini-app.

The env.sh file
---------------

All the build scripts include the `env.sh` file. This can set some 
package related (`PK_XXXXX` ) env variables to specify paths, load
modules, and set compiler / linker variables. In addition the file
specifies locations of the source, build and install directories. 
To adapt to a new system typically the following would need to be set:

* `SRCDIR` identifies the location of sources (defaults to `./src`)
* `BUILDDIR` identifies the location of out of source build directories (defaults to `./build`)
* `INSTALLDIR` identifies the location to install dependencies (defaults to `./install`)
* `PK_CXX` - the C++ compiler
* `PK_CC`  - the C compiler
* `PK_CXXFLAGS` and `PK_CFLAGS` -- compiler flags
* `PK_LDFLAGS` and `PK_LIBS` -- linker flags

QDP++ (`qdpxx`) can be built with OpenMP threading. In order to use this feature
one needs to pass `--enable-openmp` to their configuration. 
This is set in the option `PK_OMP_ENABLE`. If you don't want openMP in these
packages, set the variable to an empty string.

The build_xxxx.sh files
-----------------------

The `build_xxxx.sh` files will build either `SyCLDslash` or its dependencies.
These files typically perform configuration by invoking `configure` (for 
`libxml2`, QDP++ (`qdpxx`)) or CMake (for `SyCLDslash`) and then call `make` 
to build and install the dependencies. `SyCLDslash` is built, but not installed,
and should be run from the `build` directory.

Some options for SyCLDslash (`build_sycl_dslash.sh`) are as follows:

* `-DQDPXX_DIR=<qdpxx_install_dir>/share` points to the `share` direcotry of a QDP++ installation which contains a `FindQDPXX.cmake` file.
* `-DMG_FORTRANLIKE_COMPLEX=ON` enables (RIRIRIRI) storage for complex numbers in 
vectors. Turning it to 'OFF' specifies a more 'vector-like' complex number storage (RRRR...)(IIII...)
* `-DMG_USE_LAYOUT_LEFT=OFF` ( if set to `ON` selects left index fastest indexing for View objects, if 
  set to `OFF` uses right fastest indexing, following Kokkos. )
 


Running The Mini-App:
=====================

Once building is complete the executables will be in `build/build_sycl_dslash/tests`
Two executables are of primary interest: `test_dslash_sycl` and `test_dslash_sycl_vperf`.

The `test_dslash_sycl` app performs some unit testing of the dslash operator for a selection
of vector lenghts.

The performance test is `test_dslash_sycl_vperf` which will first apply a dslash for the 
purposes of JIT-compiling all the components, and then it will apply dslash again to time
a single application. It will use this timing to choose a number of iterations commensurate
to 5 seconds of runtime or minimally 1 iteration if it takes longer than 5 seconds. It will
then perform 5 timing loops. 

Known issues
=============
 - The code has been tested only with the Intel LLVM/SyCL compiler which is in development,
on a system running an OpenCL runtime. It occasionally crashes OpenCL with the error message:

```OpenCL API failed. OpenCL API returns: -34 (CL_INVALID_CONTEXT)```

This issue needs to be chased down still.

Licensing and copyright
=======================

The Jefferson Lab License under which this workspace is distributed is in the file `LICENSE`
Licenses for dependencies are included in their source code and/or in the `LICENSES` directory.
 


