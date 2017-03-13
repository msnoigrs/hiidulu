# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 python3_5 python3_6 )

EGIT_REPO_URI="https://github.com/dano/aioprocessing.git"

inherit distutils-r1 git-r3

DESCRIPTION="the multiprocessing module with asyncio"
HOMEPAGE="https://github.com/dano/aioprocessing"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
