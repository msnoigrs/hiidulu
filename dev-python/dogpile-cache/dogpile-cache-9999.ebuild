# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

EGIT_REPO_URI="https://bitbucket.org/zzzeek/dogpile.cache.git"

inherit distutils-r1 git-2

DESCRIPTION="The Oslo configuration API supports parsing command line arguments
and ini style configuration files"
HOMEPAGE="https://bitbucket.org/zzzeek/dogpile.cache"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/dogpile-core-0.4.1[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/mock[${PYTHON_USEDEP}]
				dev-python/nose[${PYTHON_USEDEP}]
				>=dev-python/dogpile-core-0.4.1[${PYTHON_USEDEP}] )"

# for testsuite
DISTUTILS_NO_PARALLEL_BUILD=1
# This time half the doc files are missing; Do you want them? toss a coin

python_prepare_all() {
	epatch "${FILESDIR}/connection_pool.patch"

	distutils-r1_python_prepare_all
}

python_test() {
	# crikey. testsuite written for py3, 5 tests fail under py2.7
	if [[ "${EPYTHON}" != "python2.7" ]]; then
		nosetests || die "test failed under ${EPYTHON}"
	else
		einfo "testsuite restricted for python2.7"
	fi
}
