# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python3_3 python3_4 python3_5 )

EGIT_REPO_URI="https://github.com/Lupino/aiobottle.git"

inherit distutils-r1 git-2

DESCRIPTION="a warper bottle use aiohttp base on Asyncio (PEP-3156)"
HOMEPAGE="https://github.com/Lupino/aiobottle"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/aiohttp"
RDEPEND="${DEPEND}"
