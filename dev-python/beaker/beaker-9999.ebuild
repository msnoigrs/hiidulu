# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} )

EGIT_REPO_URI="https://github.com/bbangert/beaker.git"

inherit distutils-r1 git-2


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
		dev-python/webtest[$(python_gen_usedep python{2_6,2_7,3_2,3_3,3_4})] )"
RDEPEND=""

python_prepare_all() {
	# Workaround for http://bugs.python.org/issue11276.
	#sed -e "s/import anydbm/& as anydbm/;/import anydbm/a dbm = anydbm" \
	#	-i beaker/container.py || die

	#sed -i -e 's/KeyError, e/KeyError as e/' beaker/cache.py

	epatch "${FILESDIR}/py3.patch"

	mv tests t
	distutils-r1_python_prepare_all
}

python_test() {
	mv t tests
	cp -r -l tests "${BUILD_DIR}"/ || die

	if [[ ${EPYTHON} == python3.* ]]; then
		# Notes:
		#   -W is not supported by python3.1
		#   -n causes Python to write into hardlinked files
		2to3 --no-diffs -w "${BUILD_DIR}"/tests || die
	fi

	cd "${BUILD_DIR}"/tests || die
	nosetests || die "Tests fail with ${EPYTHON}"
}
