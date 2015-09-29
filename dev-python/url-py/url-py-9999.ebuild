# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

#EGIT_REPO_URI="https://github.com/seomoz/url-py.git"
EGIT_REPO_URI="https://github.com/masayuko/url-py"

inherit distutils-r1 git-2

DESCRIPTION="URL Transformation, Sanitization"
HOMEPAGE="https://github.com/seomoz/url-py"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/publicsuffix
	test? ( dev-python/nose[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

python_test() {
	mkdir "${BUILD_DIR}"/tests || die
	cp -l test.py "${BUILD_DIR}"/tests || die

	cd "${BUILD_DIR}"/tests || die
	nosetests -s -v -d --with-coverage --cover-package=url test.py || die "Tests fail with ${EPYTHON}"
}
