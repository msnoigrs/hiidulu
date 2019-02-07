# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="The Oslo configuration API supports parsing command line arguments
and ini style configuration files"
HOMEPAGE="https://bitbucket.org/zzzeek/dogpile.cache"
SRC_URI="mirror://pypi/${PN:0:1}/dogpile.cache/dogpile.cache-${PV}.tar.gz"
S="${WORKDIR}/dogpile.cache-${PV}"

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

#python_prepare_all() {
#	epatch "${FILESDIR}/connection_pool.patch"
#
#	distutils-r1_python_prepare_all
#}

python_test() {
	# crikey. testsuite written for py3, 5 tests fail under py2.7
	if [[ "${EPYTHON}" != "python2.7" ]]; then
		nosetests || die "test failed under ${EPYTHON}"
	else
		einfo "testsuite restricted for python2.7"
	fi
}
