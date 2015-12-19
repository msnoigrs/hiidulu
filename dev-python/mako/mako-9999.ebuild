# Copyright 1998-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://bitbucket.org/zzzeek/mako.git"

inherit distutils-r1 git-2

#MY_P="Mako-${PV}"

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ http://pypi.python.org/pypi/Mako"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="doc test"

RDEPEND=">=dev-python/beaker-1.1[${PYTHON_USEDEP}]
	>=dev-python/markupsafe-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

#S="${WORKDIR}/${MY_P}"

#PATCHES=(
#	"${FILESDIR}/test-fix.patch"
#)

python_test() {
	cp -r -l test "${BUILD_DIR}"/ || die

	if [[ ${EPYTHON} == python3.* ]]; then
		# Notes:
		#   -W is not supported by python3.1
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w "${BUILD_DIR}"/test || die
	fi

	cd "${BUILD_DIR}"/test || die
	nosetests || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	rm -rf doc/build

	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}
