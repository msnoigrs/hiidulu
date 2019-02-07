# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 python3_6 python3_7 )

EGIT_REPO_URI="https://github.com/KeepSafe/aiohttp.git"

inherit distutils-r1 git-r3

DESCRIPTION="http client/server for asyncio"
HOMEPAGE="https://github.com/KeepSafe/aiohttp"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

#DEPEND="python_targets_python3_3? ( dev-python/asyncio[python_targets_python3_3] )"
DEPEND=""
RDEPEND="${DEPEND}"
