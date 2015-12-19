# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

#EGIT_REPO_URI="https://github.com/masayuko/astodi.git"
EGIT_REPO_URI="https://masayuko@bitbucket.org/masayuko/astodi.git"
EGIT_REPO_URI="https://github.com/hsharrison/Py2D.git"

inherit distutils-r1 git-2

DESCRIPTION="Py2D library of 2D-game-related algorithms"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="http://sseemayer.github.io/Py2D/index.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#DEPEND="dev-python/lxml"
#RDEPEND="${DEPEND}"
