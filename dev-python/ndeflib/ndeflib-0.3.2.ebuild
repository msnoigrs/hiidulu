# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{6,7}} )

inherit distutils-r1

DESCRIPTION="Parsing and generating NFC Data Exchange Format (NDEF) messages"
HOMEPAGE="https://github.com/nfcpy/ndeflib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
#SRC_URI="https://github.com/nfcpy/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"


LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE=""
