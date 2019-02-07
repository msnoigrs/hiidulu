# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_5 python3_6 python3_7 )

EGIT_REPO_URI="https://github.com/tkf/sexpdata.git"

inherit distutils-r1 alternatives git-r3

DESCRIPTION="S-expression parser for Python"
HOMEPAGE="https://github.com/tkf/sexpdata"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND=""
#RDEPEND="${DEPEND}"
