# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/nvie/rq.git"

inherit distutils-r1 git-r3

DESCRIPTION="Easy job queues for python"
HOMEPAGE="http://python-rq.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

CDEPEND="dev-python/click[${PYTHON_USEDEP}]"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	>=dev-db/redis-2.7.0"
