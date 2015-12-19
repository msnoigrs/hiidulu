# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://github.com/masayuko/python-robotstxt.git"

inherit distutils-r1 git-2

DESCRIPTION="A robots.txt Manipulation Library for Python"
HOMEPAGE="https://github.com/masayuko/python-robotstxt"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/urilib
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

python_test() {
	cp -r tests "${BUILD_DIR}" || die

	cd "${BUILD_DIR}"/tests || die
	py.test || die "Tests fail with ${EPYTHON}"
}
