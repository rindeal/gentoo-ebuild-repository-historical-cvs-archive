# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/ruby-fakegem.eclass,v 1.29 2011/04/25 08:36:51 graaff Exp $
#
# @ECLASS: ruby-fakegem.eclass
# @MAINTAINER:
# Ruby herd <ruby@gentoo.org>
#
# Author: Diego E. Pettenò <flameeyes@gentoo.org>
#
# Author: Alex Legler <a3li@gentoo.org>
#
# @BLURB: An eclass for installing Ruby packages to behave like RubyGems.
# @DESCRIPTION:
# This eclass allows to install arbitrary Ruby libraries (including Gems),
# providing integration into the RubyGems system even for "regular" packages.
#

inherit ruby-ng

# @ECLASS-VARIABLE: RUBY_FAKEGEM_NAME
# @DESCRIPTION:
# Sets the Gem name for the generated fake gemspec.
# RUBY_FAKEGEM_NAME="${PN}"

# @ECLASS-VARIABLE: RUBY_FAKEGEM_VERSION
# @DESCRIPTION:
# Sets the Gem version for the generated fake gemspec.
# RUBY_FAKEGEM_VERSION="${PV}"

# @ECLASS-VARIABLE: RUBY_FAKEGEM_TASK_DOC
# @DESCRIPTION:
# Specify the rake(1) task to run to generate documentation.
# RUBY_FAKEGEM_TASK_DOC="rdoc"

# @ECLASS-VARIABLE: RUBY_FAKEGEM_TASK_TEST
# @DESCRIPTION:
# Specify the rake(1) task used for executing tests.
# RUBY_FAKEGEM_TASK_TEST="test"

# @ECLASS-VARIABLE: RUBY_FAKEGEM_DOCDIR
# @DESCRIPTION:
# Specify the directory under which the documentation is built;
# if empty no documentation will be installed automatically.
# RUBY_FAKEGEM_DOCDIR=""

# @ECLASS-VARIABLE: RUBY_FAKEGEM_EXTRADOC
# @DESCRIPTION:
# Extra documentation to install (readme, changelogs, …).
# RUBY_FAKEGEM_EXTRADOC=""

# @ECLASS-VARIABLE: RUBY_FAKEGEM_BINWRAP
# @DESCRIPTION:
# Binaries to wrap around (relative to the bin/ directory)
# RUBY_FAKEGEM_BINWRAP="*"

# @ECLASS-VARIABLE: RUBY_FAKEGEM_REQUIRE_PATHS
# @DESCRIPTION:
# Extra require paths (beside lib) to add to the specification
# RUBY_FAKEGEM_REQUIRE_PATHS=""

# @ECLASS-VARIABLE: RUBY_FAKEGEM_GEMSPEC
# @DESCRIPTION:
# Filename of .gemspec file to install instead of generating a generic one.
# RUBY_FAKEGEM_GEMSPEC=""

RUBY_FAKEGEM_NAME="${RUBY_FAKEGEM_NAME:-${PN}}"
RUBY_FAKEGEM_VERSION="${RUBY_FAKEGEM_VERSION:-${PV/_pre/.pre}}"
RUBY_FAKEGEM_SUFFIX="${RUBY_FAKEGEM_SUFFIX:-}"

RUBY_FAKEGEM_TASK_DOC="${RUBY_FAKEGEM_TASK_DOC-rdoc}"
RUBY_FAKEGEM_TASK_TEST="${RUBY_FAKEGEM_TASK_TEST-test}"

RUBY_FAKEGEM_BINWRAP="${RUBY_FAKEGEM_BINWRAP-*}"

if [[ ${RUBY_FAKEGEM_TASK_DOC} != "" ]]; then
	IUSE="$IUSE doc"
	ruby_add_bdepend "doc? ( dev-ruby/rake )"
fi

if [[ -n ${RUBY_FAKEGEM_DOCDIR} ]]; then
	IUSE="$IUSE doc"
fi

if [[ ${RUBY_FAKEGEM_TASK_TEST} != "" ]]; then
	IUSE="$IUSE test"
	ruby_add_bdepend "test? ( dev-ruby/rake )"
fi

SRC_URI="mirror://rubygems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}${RUBY_FAKEGEM_SUFFIX:+-${RUBY_FAKEGEM_SUFFIX}}.gem"

ruby_add_bdepend dev-ruby/rubygems
ruby_add_rdepend dev-ruby/rubygems

# @FUNCTION: ruby_fakegem_gemsdir
# @RETURN: Returns the gem data directory
# @DESCRIPTION:
# This function returns the gems data directory for the ruby
# implementation in question.
ruby_fakegem_gemsdir() {
	has "${EAPI}" 2 && ! use prefix && EPREFIX=

	local _gemsitedir=$(ruby_rbconfig_value 'sitelibdir')
	_gemsitedir=${_gemsitedir//site_ruby/gems}
	_gemsitedir=${_gemsitedir#${EPREFIX}}

	[[ -z ${_gemsitedir} ]] && {
		eerror "Unable to find the gems dir"
		die "Unable to find the gems dir"
	}

	echo "${_gemsitedir}"
}

# @FUNCTION: ruby_fakegem_doins
# @USAGE: file [file...]
# @DESCRIPTION:
# Installs the specified file(s) into the gems directory.
ruby_fakegem_doins() {
	(
		insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}
		doins "$@"
	) || die "failed $0 $@"
}

# @FUNCTION: ruby_fakegem_newsins()
# @USAGE: file filename
# @DESCRIPTION:
# Installs the specified file into the gems directory using the provided filename.
ruby_fakegem_newins() {
	(
		# Since newins does not accept full paths but just basenames
		# for the target file, we want to extend it here.
		local newdirname=/$(dirname "$2")
		[[ ${newdirname} == "/." ]] && newdirname=

		local newbasename=$(basename "$2")

		insinto $(ruby_fakegem_gemsdir)/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}${newdirname}
		newins "$1" ${newbasename}
	) || die "failed $0 $@"
}

# @FUNCTION: ruby_fakegem_install_gemspec
# @DESCRIPTION:
# Install a .gemspec file for this package. Either use the file indicated
# by the RUBY_FAKEGEM_GEMSPEC variable, or generate one using
# ruby_fakegem_genspec.
ruby_fakegem_install_gemspec() {
	local gemspec="${T}"/${RUBY_FAKEGEM_NAME}-${_ruby_implementation}

	(
		if [[ ${RUBY_FAKEGEM_GEMSPEC} != "" ]]; then
			ruby_fakegem_gemspec_gemspec ${RUBY_FAKEGEM_GEMSPEC} ${gemspec}
		else
			local metadata="${WORKDIR}"/${_ruby_implementation}/metadata

			if [[ -e ${metadata} ]]; then
				ruby_fakegem_metadata_gemspec ${metadata} ${gemspec}
			else
				ruby_fakegem_genspec ${gemspec}
			fi
		fi
	) || die "Unable to generate gemspec file."

	insinto $(ruby_fakegem_gemsdir)/specifications
	newins ${gemspec} ${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}.gemspec || die "Unable to install gemspec file."
}

# @FUNCTION: ruby_fakegem_gemspec_gemspec
# @USAGE: gemspec-input gemspec-output
# @DESCRIPTION:
# Generates an installable version of the specification indicated by
# RUBY_FAKEGEM_GEMSPEC. This file is eval'ed to produce a final specification
# in a way similar to packaging the gemspec file.
ruby_fakegem_gemspec_gemspec() {
	${RUBY} -e "puts eval(File::open('$1').read).to_ruby" > $2
}

# @FUNCTION: ruby_fakegem_metadata_gemspec
# @USAGE: gemspec-metadata gemspec-output
# @DESCRIPTION:
# Generates an installable version of the specification indicated by
# the metadata distributed by the gem itself. This is similar to how
# rubygems creates an installation from a .gem file.
ruby_fakegem_metadata_gemspec() {
	${RUBY} -r yaml -e "puts Gem::Specification.from_yaml(File::open('$1').read).to_ruby" > $2
}

# @FUNCTION: ruby_fakegem_genspec
# @USAGE: output-gemspec
# @DESCRIPTION:
# Generates a gemspec for the package and places it into the "specifications"
# directory of RubyGems.
# If the metadata normally distributed with a gem is present then that is
# used to generate the gemspec file.
#
# As a fallback we can generate our own version.
# In the gemspec, the following values are set: name, version, summary,
# homepage, and require_paths=["lib"].
# See RUBY_FAKEGEM_NAME and RUBY_FAKEGEM_VERSION for setting name and version.
# See RUBY_FAKEGEM_REQUIRE_PATHS for setting extra require paths.
ruby_fakegem_genspec() {
	local required_paths="'lib'"
	for path in ${RUBY_FAKEGEM_REQUIRE_PATHS}; do
		required_paths="${required_paths}, '${path}'"
	done

	# We use the _ruby_implementation variable to avoid having stray
	# copies with different implementations; while for now we're using
	# the same exact content, we might have differences in the future,
	# so better taking this into consideration.
	local quoted_description=${DESCRIPTION//\"/\\\"}
	cat - > $1 <<EOF
# generated by ruby-fakegem.eclass $Revision: 1.29 $
Gem::Specification.new do |s|
  s.name = "${RUBY_FAKEGEM_NAME}"
  s.version = "${RUBY_FAKEGEM_VERSION}"
  s.summary = "${quoted_description}"
  s.homepage = "${HOMEPAGE}"
  s.require_paths = [${required_paths}]
end
EOF
}

# @FUNCTION: ruby_fakegem_binwrapper
# @USAGE: command [path]
# @DESCRIPTION:
# Creates a new binary wrapper for a command installed by the RubyGem.
# path defaults to /usr/bin/$command
ruby_fakegem_binwrapper() {
	(
		local gembinary=$1
		local newbinary=${2:-/usr/bin/$gembinary}
		local relativegembinary=${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/bin/${gembinary}
		local binpath=$(dirname $newbinary)
		[[ ${binpath} = . ]] && binpath=/usr/bin

		# Try to find out whether the package is going to install for
		# one or multiple implementations; if we're installing for a
		# *single* implementation, no need to use “/usr/bin/env ruby”
		# in the shebang, and we can actually avoid errors when
		# calling the script by default (see for instance the
		# JRuby-specific commands).
		local rubycmd=
		for implementation in ${USE_RUBY}; do
			# ignore non-enabled implementations
			use ruby_targets_${implementation} || continue
			if [ -z $rubycmd ]; then
				# if no other implementation was set before, set it.
				rubycmd="$(ruby_implementation_command ${implementation})"
			else
				# if another implementation already arrived, then make
				# it generic and break out of the loop. This ensures
				# that we do at most two iterations.
				rubycmd="/usr/bin/env ruby"
				break
			fi
		done

		cat - > "${T}"/gembin-wrapper-${gembinary} <<EOF
#!${rubycmd}
# This is a simplified version of the RubyGems wrapper
#
# Generated by ruby-fakegem.eclass $Revision: 1.29 $

require 'rubygems'

load Gem::default_path[-1] + "/gems/${relativegembinary}"

EOF

		exeinto ${binpath:-/usr/bin}
		newexe "${T}"/gembin-wrapper-${gembinary} $(basename $newbinary)
	) || die "Unable to create fakegem wrapper"
}

# @FUNCTION: all_fakegem_compile
# @DESCRIPTION:
# Build documentation for the package if indicated by the doc USE flag
# and if there is a documetation task defined.
all_fakegem_compile() {
	if [[ ${RUBY_FAKEGEM_TASK_DOC} != "" ]] && use doc; then
		rake ${RUBY_FAKEGEM_TASK_DOC} || die "failed to (re)build documentation"
	fi
}

# @FUNCTION: all_ruby_unpack
# @DESCRIPTION:
# Unpack the source archive, including support for unpacking gems.
all_ruby_unpack() {
	# Special support for extracting .gem files; the file need to be
	# extracted twice and the mtime from the archive _has_ to be
	# ignored (it's always set to epoch 0).
	for archive in ${A}; do
		case "${archive}" in
			*.gem)
				# Make sure that we're not running unpack for more than
				# one .gem file, since we won't support that at all.
				[[ -d "${S}" ]] && die "Unable to unpack ${archive}, ${S} exists"

				ebegin "Unpacking .gem file..."
				tar -mxf ${DISTDIR}/${archive} || die
				eend $?

				ebegin "Uncompressing metadata"
				gunzip metadata.gz || die
				eend $?

				mkdir "${S}"
				pushd "${S}" &>/dev/null

				ebegin "Unpacking data.tar.gz"
				tar -mxf "${my_WORKDIR}"/data.tar.gz || die
				eend $?

				popd &>/dev/null
				;;
			*.patch.bz2)
				# We apply the patches with RUBY_PATCHES directly from DISTDIR,
				# as the WORKDIR variable changes value between the global-scope
				# and the time all_ruby_unpack/_prepare are called. Since we can
				# simply decompress them when applying, this is much easier to
				# deal with for us.
				einfo "Keeping ${archive} as-is"
				;;
			*)
				unpack ${archive}
				;;
		esac
	done
}

# @FUNCTION: all_ruby_compile
# @DESCRIPTION:
# Compile the package.
all_ruby_compile() {
	all_fakegem_compile
}

# @FUNCTION: each_fakegem_test
# @DESCRIPTION:
# Run tests for the package for each ruby target if the test task is defined.
each_fakegem_test() {
	local rubyflags=
	${RUBY} ${rubyflags} -S rake ${RUBY_FAKEGEM_TASK_TEST} || die "tests failed"
}

if [[ ${RUBY_FAKEGEM_TASK_TEST} != "" ]]; then
	# @FUNCTION: each_ruby_test
	# @DESCRIPTION:
	# Run the tests for this package.
	each_ruby_test() {
		each_fakegem_test
	}
fi

# @FUNCTION: each_fakegem_install
# @DESCRIPTION:
# Install the package for each ruby target.
each_fakegem_install() {
	ruby_fakegem_install_gemspec

	local _gemlibdirs="${RUBY_FAKEGEM_EXTRAINSTALL}"
	for directory in bin lib; do
		[[ -d ${directory} ]] && _gemlibdirs="${_gemlibdirs} ${directory}"
	done

	[[ -n ${_gemlibdirs} ]] && \
		ruby_fakegem_doins -r ${_gemlibdirs}
}

# @FUNCTION: each_ruby_install
# @DESCRIPTION:
# Install the package for each target.
each_ruby_install() {
	each_fakegem_install
}

# @FUNCTION: all_fakegem_install
# @DESCRIPTION:
# Install files common to all ruby targets.
all_fakegem_install() {
	if [[ -n ${RUBY_FAKEGEM_DOCDIR} ]] && use doc; then
		for dir in ${RUBY_FAKEGEM_DOCDIR}; do
			[[ -d ${dir} ]] || continue

			pushd ${dir} &>/dev/null
			dohtml -r * || die "failed to install documentation"
			popd &>/dev/null
		done
	fi

	if [[ -n ${RUBY_FAKEGEM_EXTRADOC} ]]; then
		dodoc ${RUBY_FAKEGEM_EXTRADOC} || die "failed to install further documentation"
	fi

	# binary wrappers; we assume that all the implementations get the
	# same binaries, or something is wrong anyway, so...
	if [[ -n ${RUBY_FAKEGEM_BINWRAP} ]]; then
		local bindir=$(find "${D}" -type d -path "*/gems/${RUBY_FAKEGEM_NAME}-${RUBY_FAKEGEM_VERSION}/bin" -print -quit)

		if [[ -d "${bindir}" ]]; then
			pushd "${bindir}" &>/dev/null
			local binaries=$(eval ls ${RUBY_FAKEGEM_BINWRAP})
			for binary in $binaries; do
				ruby_fakegem_binwrapper $binary
			done
			popd &>/dev/null
		fi
	fi
}

# @FUNCTION: all_ruby_install
# @DESCRIPTION:
# Install files common to all ruby targets.
all_ruby_install() {
	all_fakegem_install
}
