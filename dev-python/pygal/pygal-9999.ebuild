# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

EGIT_REPO_URI="https://github.com/Kozea/pygal.git"

inherit distutils-r1 git-2

DESCRIPTION="A python SVG Charts Creator"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://pygal.org"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS=""
#KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/lxml"
RDEPEND="${DEPEND}"
