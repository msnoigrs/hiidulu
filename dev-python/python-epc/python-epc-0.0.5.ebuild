# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 )

inherit distutils-r1 alternatives

DESCRIPTION="EPC (RPC stack for Emacs Lisp) implementation in Python"
HOMEPAGE="https://github.com/tkf/python-epc"
SRC_URI="mirror://pypi/e/epc/epc-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND=""
#RDEPEND="${DEPEND}"

S="${WORKDIR}/epc-${PV}"
