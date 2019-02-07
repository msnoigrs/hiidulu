# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_5 python3_6 python3_7 )

EGIT_REPO_URI="https://github.com/Lupino/aiobottle.git"

inherit distutils-r1 git-r3

DESCRIPTION="a warper bottle use aiohttp base on Asyncio (PEP-3156)"
HOMEPAGE="https://github.com/Lupino/aiobottle"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/aiohttp"
RDEPEND="${DEPEND}"
