# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_5,3_6,3_7} )

inherit distutils-r1

DESCRIPTION="An asyncio API for the Tkinter event loop"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/montag451/aiotkinter"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
