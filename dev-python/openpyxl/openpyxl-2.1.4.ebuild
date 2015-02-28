# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="Pure python reader and writer of Excel OpenXML files"
HOMEPAGE="http://bitbucket.org/ericgazoni/openpyxl/wiki/Home"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-python/nose[${PYTHON_USEDEP}] )"

# Upstream:
# Openpyxl supports python (even if some tests can fail on 2.4) from 2.4 to 3.2.
RESTRICT="test"

python_test() {
	esetup.py test
}
