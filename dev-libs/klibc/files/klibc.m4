# klibc.m4 serial 99
## Copyright (C) 1995-2003 Free Software Foundation, Inc.
## This file is free software, distributed under the terms of the GNU
## General Public License.  As a special exception to the GNU General
## Public License, this file may be distributed as part of a program
## that contains a configuration script generated by Autoconf, under
## the same distribution terms as the rest of that program.
##
## This file can can be used in projects which are not available under
## the GNU General Public License or the GNU Library General Public
## License but which still want to provide support for the GNU gettext
## functionality.
## Please note that the actual code of the GNU gettext library is covered
## by the GNU Library General Public License, and the rest of the GNU
## gettext package package is covered by the GNU General Public License.
## They are *not* in the public domain.

# Authors:
#   Martin Schlemmer <azarah@nosferatu.za.org>, 2005.


# AC_CHECK_KLIBC
# --------------
# Check if the user wants KLIBC support enabled.  If so, set KLIBC=yes and
# fill in KLIBC_PREFIX, KLIBC_BINDIR, KLIBC_SBINDIR, KLIBC_LIBDIR and
# KLIBC_INCLUDEDIR.  CC is also set to the proper klcc executable.
# NOTE:  This should be called before AC_PROG_CC, and before header, function
#        or type checks.
AC_DEFUN([AC_CHECK_KLIBC],
[AC_BEFORE([$0], [AC_PROG_CC])
AC_REQUIRE([AC_CANONICAL_HOST])
AC_ARG_ENABLE([klibc],
              [AS_HELP_STRING([--enable-klibc],
                              [Use this to link the tools to klibc. Set KLCC
                               to the absolute file name of klcc if not in
                               the PATH.])],
              [KLIBC=yes], [KLIBC=no])

if test "X$KLIBC" = Xyes; then
  # Basic cross compiling support.  I do not think it is wise to use
  # AC_CHECK_TOOL, because if we are cross compiling, we do not want
  # just 'klcc' to be returned ...
  if test "${host_alias}" != "${build_alias}"; then
    AC_CHECK_PROGS([KLCC], [${host_alias}-klcc], [no])
  else
    AC_CHECK_PROGS([KLCC], [klcc], [no])
  fi
  if test "X$KLCC" = Xno; then
    AC_MSG_ERROR([cannot find klibc frontend 'klcc'!])
  fi

  CC="$KLCC"
  CFLAGS="-Os"
  KLIBC_KCROSS="$($KLCC -print-klibc-kcross 2>/dev/null)"
  KLIBC_PREFIX="$($KLCC -print-klibc-prefix 2>/dev/null)"
  KLIBC_BIN_DIR="$($KLCC -print-klibc-bindir 2>/dev/null)"
  KLIBC_SBIN_DIR="${KLIBC_PREFIX}/${KLIBC_KCROSS}sbin"
  KLIBC_LIB_DIR="$($KLCC -print-klibc-libdir 2>/dev/null)"
  KLIBC_INCLUDE_DIR="$($KLCC -print-klibc-includedir 2>/dev/null)"

  # At least KLIBC_LIB_DIR should be valid, else klibc is too old or
  # something went wrong
  if test ! -d "$KLIBC_LIB_DIR"; then
    AC_MSG_ERROR([your klibc installation is too old or not functional!])
  fi
fi

AC_SUBST(KLIBC)
AC_SUBST(KLIBC_PREFIX)
AC_SUBST(KLIBC_BIN_DIR)
AC_SUBST(KLIBC_SBIN_DIR)
AC_SUBST(KLIBC_LIB_DIR)
AC_SUBST(KLIBC_INCLUDE_DIR)
])# AC_CHECK_KLIBC

