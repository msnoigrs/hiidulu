# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

#EGIT_REPO_URI="https://github.com/masayuko/publicsuffix.git"
#EGIT_REPO_URI="https://github.com/pombredanne/python-publicsuffix2.git"
EGIT_REPO_URI="https://github.com/masayuko/python-publicsuffix2.git"

inherit distutils-r1 git-2

DESCRIPTION="Public Suffix List module for Python"
HOMEPAGE="https://github.com/PressLabs/publicsuffix"

LICENSE="MIT MPL-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

python_test() {
	mkdir "${BUILD_DIR}"/tests || die
	cp -l tests.py "${BUILD_DIR}"/tests || die

	cd "${BUILD_DIR}"/tests || die
	nosetests -s -v -d --with-coverage --cover-package=url tests.py || die "Tests fail with ${EPYTHON}"
}
