# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Network diagram generator"
HOMEPAGE="http://blockdiag.com/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/pillow
	dev-python/webcolors
	dev-python/funcparserlib
	dev-python/setuptools
	app-office/blockdiag"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/include_package_data=True/ d' setup.py
}
