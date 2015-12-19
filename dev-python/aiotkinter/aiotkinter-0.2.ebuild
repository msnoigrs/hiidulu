# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5} )

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
