# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

#EGIT_REPO_URI="https://github.com/bbangert/beaker.git"
EGIT_REPO_URI="https://github.com/msnoigrs/beaker.git"
EGIT_BRANCH="rework2"
#EGIT_BRANCH="rework"

inherit distutils-r1 git-r3


DESCRIPTION="A Session and Caching library with WSGI Middleware"
HOMEPAGE="http://beaker.groovie.org/ http://pypi.python.org/pypi/Beaker"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="test"

# webtest-based tests are skipped when webtest is not installed
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/webtest[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/pycrypto[${PYTHON_USEDEP}] )"
RDEPEND=""

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_test() {
	cp -r -l tests "${BUILD_DIR}"/ || die

	cd "${BUILD_DIR}"/tests || die
	nosetests -s -v -d --with-coverage --cover-package=beaker || die "Tests fail with ${EPYTHON}"
}
