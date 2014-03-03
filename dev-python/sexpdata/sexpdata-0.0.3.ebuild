# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 )

inherit distutils-r1 alternatives

DESCRIPTION="S-expression parser for Python"
HOMEPAGE="https://github.com/tkf/sexpdata"
SRC_URI="mirror://pypi/s/sexpdata/sexpdata-${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND=""
#RDEPEND="${DEPEND}"
