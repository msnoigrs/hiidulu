# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="Activity diagram generator"
HOMEPAGE="http://blockdiag.com/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

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
