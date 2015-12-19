# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )

EGIT_REPO_URI="https://github.com/nvie/rq.git"

inherit distutils-r1 git-2

DESCRIPTION="Easy job queues for python"
HOMEPAGE="http://python-rq.org"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

#DEPEND=""
RDEPEND=">=dev-db/redis-2.7.0"
