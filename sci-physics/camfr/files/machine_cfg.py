# This Python script contains all the machine dependent settings
# needed during the build process.

# Get compiler flags from Gentoo's /etc/make.conf.

import popen2

r, w = popen2.popen2("source /etc/make.conf ; echo $CXXFLAGS")
CXXFLAGS = r.readline().strip()
r.close()
w.close()

# Compilers to be used.

cc  = "gcc"
cxx = "g++"
f77 = "gfortran -fPIC"

link = cxx
link_flags = ""

# Compiler flags.
#
# Note: for the Fortran name definition you can define one of the following
#       preprocessor macros:
#
#           FORTRAN_SYMBOLS_WITHOUT_TRAILING_UNDERSCORES
#           FORTRAN_SYMBOLS_WITH_SINGLE_TRAILING_UNDERSCORE
#           FORTRAN_SYMBOLS_WITH_DOUBLE_TRAILING_UNDERSCORES

base_flags = "-ftemplate-depth-60 \
	      -DFORTRAN_SYMBOLS_WITH_SINGLE_TRAILING_UNDERSCORE -DNDEBUG"

flags_noopt = base_flags
flags = base_flags + CXXFLAGS
fflags = flags

# Include directories.

include_dirs = ["/usr/include/python2.4"]

# Library directories.

library_dirs = [""]

# Library names.

libs = ["boost_python", "blitz", "lapack", "blas", "gfortran"]

# Command to strip library of excess symbols:

dllsuffix = ".so"
strip_command = "strip --strip-unneeded camfr/_camfr" + dllsuffix

# Extra files to copy into installation directory.

extra_files = [("doc", ["docs/camfr.pdf"])]
