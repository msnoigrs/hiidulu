# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

EGIT_REPO_URI="https://github.com/masayuko/urilib.git"

inherit distutils-r1 git-r3

DESCRIPTION="Encode like brower does, scheme-agnostic replacement for urlparse"
HOMEPAGE="https://github.com/masayuko/urilib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"
RDEPEND="${DEPEND}"

python_test() {
	cp -r tests "${BUILD_DIR}" || die

	cd "${BUILD_DIR}"/tests || die
	py.test || die "Tests fail with ${EPYTHON}"
}
