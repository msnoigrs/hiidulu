# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/transifex/transifex-client.git"

inherit distutils-r1 git-r3

DESCRIPTION="A command line interface for Transifex"
HOMEPAGE="https://pypi.python.org/pypi/transifex-client http://www.transifex.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=""
