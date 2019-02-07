# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/hsharrison/Py2D.git"

inherit distutils-r1 git-r3

DESCRIPTION="Py2D library of 2D-game-related algorithms"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://sseemayer.github.io/Py2D/index.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DEPEND="dev-python/lxml"
#RDEPEND="${DEPEND}"
