# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Network diagram generator"
HOMEPAGE="http://blockdiag.com/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/python-imaging
	dev-python/webcolors
	dev-python/funcparserlib
	dev-python/setuptools
	app-office/blockdiag"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/nwdiag-tip.patch
	epatch "${FILESDIR}"/nwdiag-py3.patch
}
