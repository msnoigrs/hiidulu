# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 python3_7 python3_8 )

EGIT_REPO_URI="https://github.com/tkf/python-epc.git"

inherit distutils-r1 alternatives git-r3

DESCRIPTION="EPC (RPC stack for Emacs Lisp) implementation in Python"
HOMEPAGE="https://github.com/tkf/python-epc"


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND=""
#RDEPEND="${DEPEND}"

#S="${WORKDIR}/epc-${PV}"
