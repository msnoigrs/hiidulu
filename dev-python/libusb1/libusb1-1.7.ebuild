# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7}} )

inherit distutils-r1

DESCRIPTION="Python ctype-based wrapper around libusb1"
HOMEPAGE="https://github.com/vpelletier/python-libusb1"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""
