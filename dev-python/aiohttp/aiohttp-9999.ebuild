# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_4 )

EGIT_REPO_URI="https://github.com/KeepSafe/aiohttp.git"

inherit distutils-r1 git-2

DESCRIPTION="http client/server for asyncio"
HOMEPAGE="https://github.com/KeepSafe/aiohttp"


LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
