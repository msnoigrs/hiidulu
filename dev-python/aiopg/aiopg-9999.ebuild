# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{3_5,3_6,3_7} )

EGIT_REPO_URI="https://github.com/aio-libs/aiopg"

inherit distutils-r1 git-r3

DESCRIPTION="a library for accessing a PostgreSQL from the asyncio"
HOMEPAGE="https://github.com/aio-libs/aiopg"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-python/psycopg"
#	python_targets_python3_3? ( dev-python/asyncio[python_targets_python3_3] )"
RDEPEND="${DEPEND}"

RESTRICT="test"
