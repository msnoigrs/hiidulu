# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://github.com/transifex/transifex-client.git"

inherit distutils-r1 git-2

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="https://pypi.python.org/pypi/transifex-client http://www.transifex.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
