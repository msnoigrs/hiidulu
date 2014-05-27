# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Easy job queues for python"
HOMEPAGE="http://python-rq.org"
SRC_URI="https://github.com/nvie/rq/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

#DEPEND=""
RDEPEND=">=dev-db/redis-2.7.0"
