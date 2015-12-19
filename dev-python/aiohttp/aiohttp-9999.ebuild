# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_4 python3_5 )

EGIT_REPO_URI="https://github.com/KeepSafe/aiohttp.git"

inherit distutils-r1 git-2

DESCRIPTION="http client/server for asyncio"
HOMEPAGE="https://github.com/KeepSafe/aiohttp"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND="python_targets_python3_3? ( dev-python/asyncio[python_targets_python3_3] )"
DEPEND=""
RDEPEND="${DEPEND}"
