# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/masayuko/docutils-htmlwriter.git"

inherit distutils-r1 git-r3

DESCRIPTION="Htmlwriter is another HTML Writer module of Docutils"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
HOMEPAGE="https://github.com/masayuko/docutils-htmlwriter"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/docutils"
RDEPEND="${DEPEND}"
